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
    name, value = name.split("[").shift.split('=')
    value = value&.delete("'")
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

