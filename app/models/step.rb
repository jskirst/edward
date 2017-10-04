class Step < ActiveRecord::Base
  def self.match(data)
    all.find { |step| step.match?(data) }
  end

  def match?(data)
    URI.unescape(conditions)
       .split("&")
       .map { |c| c.split("=") }
       .all? { |key,value| data[key] == value }
  end

  def to_h(user_facts)
    @user_facts = user_facts
    @hsh ||= begin
      hsh = { text: text }
      hsh[:parts] = Parts.new(text, answers, facts).to_a
      hsh
    end
  end

  def answers
    @answers ||= Answers.new(text).to_h
  end

  def facts
    @facts ||= Facts.new(text, @user_facts).to_h
  end

  class Parts
    attr_reader :text, :answers, :facts

    def initialize(text, answers, facts)
      @text = text
      @answers = answers
      @facts = facts
    end

    def items
      @items ||= text.split(/\{(\{[\?@a-z_]+\})\}/)
                   .map { |i| i.split(/^([\.,])/) }
                   .flatten
                   .select { |i| i.present? }
    end

    def to_a
      items.map do |item|
        if item.starts_with?("{") && item.ends_with?("}")
          item.gsub!(/[\{\}]/, '')
          item_type = item[0]
          item[0] = ''
          if item_type == '?'
            answers[item].merge(name: item)
          elsif item_type == '@'
            { type: "text", content: facts[item] }
          else
            raise 'Unknown item type: ' + item_type
          end
        else
          { type: "text", content: item }
        end
      end
    end
  end

  class Facts
    attr_reader :text, :user_facts

    def initialize(text, user_facts)
      @text = text
      @user_facts = user_facts
    end

    def to_h
      user_facts.merge({ "user_first_name": "Giles" })
    end

    def make_callout
      return unless callout
      HTTParty.get(callout)
    end
  end

  class Answers
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def items
      @items ||= text.scan(/\{\{\?([a-z_]+)\}\}/)
                   .flatten
                   .map { |name| Answer.find_by(name: name) }
    end

    def to_a
      items.map { |a| [a.name, a.to_h] }
    end

    def to_h
      Hash[*to_a.flatten]
    end
  end
end
