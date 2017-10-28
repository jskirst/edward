class PartsCollection
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

