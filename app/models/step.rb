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

  def to_h
    @hsh ||= begin
      hsh = { text: text }
      hsh[:answers] = answers unless answers.empty?
      hsh[:parts] = Parts.new(text, answers).to_a
      hsh
    end
  end

  def answers
    @answers ||= Answers.new(text).to_h
  end

  class Parts

    def initialize(text, answers)
      @items = text.split(/\{(\{[a-z_]+\})\}/)
                   .map { |i| i.split(/([\.,])/) }
                   .flatten
      @answers = answers
    end

    def to_a
      @items.map do |item|
        if item.starts_with?("{") && item.ends_with?("}")
          item.gsub!(/[\{\}]/, '')
          {
            type: "answer",
            answer: @answers[item].merge(name: item)
          }
        else
          {
            type: "text",
            content: item
          }
        end
      end
    end
  end

  class Answers
    attr_reader :items

    def initialize(text)
      @items = text.scan(/\{\{([a-z_]+)\}\}/)
                   .flatten
                   .map { |name| Answer.find_by(name: name) }
    end

    def to_a
      @items.map { |a| [a.name, a.to_h] }
    end

    def to_h
      @hsh ||= Hash[*to_a.flatten]
    end
  end
end
