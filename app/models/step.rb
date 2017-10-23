require 'securerandom'

class Step < ActiveRecord::Base
  belongs_to :workflow

  before_save do
    self.token ||= SecureRandom::uuid
  end

  def match?(data)
    URI.unescape(conditions)
       .split("&")
       .map { |c| c.split("=") }
       .all? do |key,value|
         if key.ends_with?("!")
           data[key[0..-2]].to_s != value.to_s
         else
          data[key].to_s == value.to_s
         end
       end
  end

  def to_h(user_facts)
    @user_facts = user_facts
    @hsh ||= begin
      hsh = { text: text }
      hsh.merge!(token: token) if token
      hsh.merge!(cta: cta) if cta
      hsh.merge!(cta_class: cta_class) if cta_class
      hsh.merge!(cta_href: cta_href) if cta_href
      hsh[:parts] = Parts.new(text, answers, facts).to_a
      hsh
    end
  end

  def answers
    @answers ||= Answers.new(text, facts).to_h
  end

  def facts
    @facts ||= Facts.new(text, @user_facts, callout, callout_method, callout_body).to_h
  end

  class Parts
    attr_reader :text, :answers, :facts

    def initialize(text, answers, facts)
      @text = text
      @answers = answers
      @facts = facts
    end

    def items
      @items ||= text.split(/\{(\{[?@\$][^{]+\})\}/)
                   .map { |i| i.start_with?("{") ? [i] : i.split(/^([\.\?!,])/) } # split out punctuation that occurs at the beginning
                   .flatten
                   .map { |i| i.start_with?("{") ? [i] : i.split(/([^\.\?,!\{\}]+[\.\?!,]+)/) } # split out punctuation that does not occur at beginning but is not inside liquid block
                   .flatten
                   .map { |i| i.start_with?("{") ? [i] : i.split(/(\n)/) } # split out new lines
                   .flatten
                   .select { |i| i != '' } # remove empty items
    end

    def to_a
      items.map do |item|
        if item.starts_with?("{") && item.ends_with?("}")
          item.gsub!(/[\{\}]/, '')
          item_type = item[0]
          item[0] = ''
          if item_type == '?'
            name = item.split('=')[0]
            answer = answers[name]
            raise AnswerNotFound, "No Answer found for name: #{name}" unless answer
            answer.merge!(name: name)
            answer.merge!(value: facts[name]) if facts[name]
            answer
          elsif item_type == '@'
            { type: "text", content: facts[item] }
          elsif item_type == '$'
            path = JsonPath.new('$'+item)
            { type: "text", content: path.on(facts.to_json).first }
          else
            raise 'Unknown item type: ' + item_type
          end
        elsif item == "\n"
          { type: "newline" }
        else
          { type: "text", content: item }
        end
      end
    end

    class AnswerNotFound < StandardError; end
  end

  class Facts
    attr_reader :text, :user_facts, :callout, :callout_method, :callout_body

    def initialize(text, user_facts, callout, callout_method, callout_body)
      @text = text
      @user_facts = user_facts
      @callout = callout
      @callout_method = callout_method
      @callout_body = callout_body
      if callout
        Rails.logger.info "Calling out to: #{callout}"
        @callout_facts = make_callout
      end
    end

    def to_h
      user_facts.merge(@callout_facts || {})
    end

    def make_callout
      return unless callout
      url_template = Liquid::Template.parse(callout)
      url = url_template.render(user_facts)
      if callout_method == "get"
        HTTParty.get(url).parsed_response.symbolize_keys
      else
        body_template = Liquid::Template.parse(callout_body)
        body = body_template.render(user_facts)

        HTTParty.post(url, { body: body }).parsed_response&.symbolize_keys
      end
    end
  end

  class Answers
    attr_reader :text, :facts

    def initialize(text, facts)
      @text = text
      @facts = facts
    end

    def items
      @items ||= text.scan(/\{\{\?([^}]+)\}\}/)
                   .flatten
                   .map { |name| find_by_name(name) }
    end

    def find_by_name(name)
      name_and_value = name.split('=')
      name = name_and_value[0]
      value = name_and_value[1]&.gsub("'", '')
      answer = Answer.find_by(name: name)
      raise AnswerNotFound, "No Answer found for name: #{name}" unless answer
      answer.default_value = value if value
      answer
    end

    def to_a
      items.map { |a| [a.name, a.to_h(facts)] }
    end

    def to_h
      Hash[*to_a.flatten]
    end

    class AnswerNotFound < StandardError; end
  end
end
