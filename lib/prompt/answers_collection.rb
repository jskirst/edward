class AnswersCollection
  attr_reader :step, :text, :facts

  def initialize(step:, text:, facts:)
    @step = step
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
    answer = step.workflow.answers.find_by(name: name)
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

