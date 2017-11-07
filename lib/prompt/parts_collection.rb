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
                 .map { |i| (i.start_with?("{") || i == "\n") ? [i] : i.split(' ') }
                 .flatten
                 .select { |i| i != '' } # remove empty items
  end

  def to_a
    items.map do |item|
      if item.starts_with?("{") && item.ends_with?("}")
        item = item.slice(1..-2)
        item_type = item.slice!(0)
        if item_type == '?'
          new_question(item)
        elsif item_type == '@'
          new_value(item)
        elsif item_type == '$'
          new_json(item)
        else
          raise 'Unknown item type: ' + item_type
        end
      elsif item == "\n"
        new_newline
      else
        new_text(item)
      end
    end
  end

  def new_question(item)
    name = item.split('=')[0]
    answer = answers[name]
    raise AnswerNotFound, "No Answer found for name: #{name}" unless answer
    answer.merge!(name: name)
    answer.merge!(value: facts[name]) if facts[name]
    answer
  end

  def new_value(item)
    item_parts = item.split("[")
    item_name = item_parts.shift
    attributes = {}
    item_parts.each do |i|
      name, value = i.split("=")
      attributes[name] = value.gsub(']','')
    end
    { type: "text", content: facts[item_name] }.merge(attributes)
  end

  def new_json(item)
    path = JsonPath.new('$'+item)
    { type: "text", content: path.on(facts.to_json).first }
  end

  def new_newline
    { type: "newline" }
  end

  def new_text(item)
    { type: "text", content: item }
  end

  class AnswerNotFound < StandardError; end
end

