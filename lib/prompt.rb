require 'prompt/parts_collection'
require 'prompt/facts_collection'
require 'prompt/answers_collection'
require 'prompt/factory'

class Prompt
  attr_reader :step, :user_facts

  delegate :text, :token, :cta, :cta_class, :cta_href,
    :callout, :callout_body, :callout_method, :callout_success,
    :callout_failure_text, :callout_failure_cta, to: :step

  def initialize(step:, user_facts:)
    @step = step
    @user_facts = user_facts
  end

  def save
    to_h
  end

  def to_h
    facts
    @hsh ||= begin
      hsh = { token: token }
      if @callout_successful
        hsh.merge!(text: text)
        hsh.merge!(cta: cta) if cta
        hsh.merge!(cta_class: cta_class) if cta_class
        hsh.merge!(cta_href: cta_href) if cta_href
      else
        hsh.merge!(text: callout_failure_text)
        hsh.merge!(cta: callout_failure_cta)
        hsh.merge!(cta: cta_class) if cta_class
      end
      hsh[:parts] = PartsCollection.new(hsh[:text], answers(text: hsh[:text]), facts).to_a
      hsh
    end
  end

  def answers(text: text)
    @answers ||= AnswersCollection.new(step: step, text: text, facts: facts).to_h
  end

  def facts
    @facts ||= begin
      facts_collection = FactsCollection.new(text, @user_facts, callout, callout_method, callout_body, callout_success)
      @callout_successful = facts_collection.make_callout
      facts_collection.to_h
    end
  end
end
