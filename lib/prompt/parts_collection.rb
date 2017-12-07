class PartsCollection
  attr_reader :text, :answers, :facts

  def initialize(text, answers, facts)
    @text = text
    @answers = answers
    @facts = facts
  end

  def items
    @items ||= text.split(/\{(\{[!?@\$#][^{]+\})\}/)
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
        elsif item_type == '#'
          new_link(item)
        elsif item_type == '!'
          new_choice(item)
        else
          raise 'Unknown item type: ' + item_type
        end
      elsif item == "\n"
        new_newline
      else
        new_text(item)
      end
    end.flatten
  end

  def new_question(item)
    item_parts = item.split("[")
    name = item_parts.shift.split('=')[0]
    answer = answers[name]
    raise AnswerNotFound, "No Answer found for name: #{name}" unless answer
    answer.merge!(name: name)
    answer.merge!(value: facts[name]) if facts[name]
    answer.merge!(extract_attributes(item_parts))
    answer
  end

  def new_value(item)
    item_parts = item.split("[")
    item_name = item_parts.shift
    { type: "text", content: facts[item_name] }.merge(extract_attributes(item_parts))
  end

  def new_link(item)
    item_parts = item.split("[")
    item_text = item_parts.shift
    { type: "link", content: item_text.delete("'") }.merge(extract_attributes(item_parts))
  end

  def new_choice(item)
    item_parts = item.split("[")
    item_text = item_parts.shift
    { type: "choice", content: item_text.delete("'") }.merge(extract_attributes(item_parts))
  end

  def extract_attributes(item_parts)
    attributes = {}
    item_parts.each do |i|
      name, value = i.split("=")
      value = value.delete(']')
      attributes[name] = value.start_with?("@") ? facts[value.slice(1..-1)] : value
    end
    attributes
  end

  def new_json(item)
    path = JsonPath.new('$'+item)
    content = path.on(facts.to_json).first
    content.to_s.split(" ").map do |c|
      new_text(c)
    end
  end

  def new_newline
    { type: "newline" }
  end

  def new_text(item)
    attrs = {}
    if item.start_with?("**")
      item.slice!(0,2)
      attrs['bold'] = 'true'
    end
    { type: "text", content: item }.merge(attrs)
  end

  class AnswerNotFound < StandardError; end
end

