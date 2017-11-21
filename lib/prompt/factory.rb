require 'prompt'

class Prompt::Factory
  attr_reader :workflow

  def initialize(workflow)
    @workflow = workflow
  end

  def new(facts)
    facts = facts.to_h["facts"]
    matched_step = workflow.steps.find { |step| step.match?(facts) }
    return Prompt.new(step: matched_step, user_facts: facts) if matched_step
    raise UnmatchableDataError, "No matching step found."
  end

  class UnmatchableDataError < StandardError; end
end
