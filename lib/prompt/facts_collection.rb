class FactsCollection
  attr_reader :text, :user_facts, :callout, :callout_method, :callout_body, :callout_response, :callout_success

  def initialize(text, user_facts, callout)
    @text = text
    @user_facts = user_facts
    @callout = callout
    @callout_method = callout_method
    @callout_body = callout_body
    @callout_success = callout_success
  end

  def to_h
    user_facts.merge(@callout_facts || {})
  end

  def make_callout
    return true unless callout
    callout.make
  end

  private

  def callout_successful?
    return true unless callout_success
    callout.successful?
  end
end

