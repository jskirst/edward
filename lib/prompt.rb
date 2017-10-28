require 'prompt/parts_collection'
require 'prompt/facts_collection'
require 'prompt/answers_collection'
require 'prompt/factory'

class Prompt
  attr_reader :step, :user_facts

  delegate :text, :token, :cta, :cta_class, :cta_href,
    :callout, :callout_body, :callout_method, to: :step

  def initialize(step:, user_facts:)
    @step = step
    @user_facts = user_facts
  end

  def save
    to_h
  end

  def to_h
    @hsh ||= begin
      hsh = { text: text }
      hsh.merge!(token: token) if token
      hsh.merge!(cta: cta) if cta
      hsh.merge!(cta_class: cta_class) if cta_class
      hsh.merge!(cta_href: cta_href) if cta_href
      hsh[:parts] = PartsCollection.new(text, answers, facts).to_a
      hsh
    end
  end

  def answers
    @answers ||= AnswersCollection.new(step: step, text: text, facts: facts).to_h
  end

  def facts
    @facts ||= FactsCollection.new(text, @user_facts, callout, callout_method, callout_body).to_h
  end
end
