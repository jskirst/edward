require 'prompt/parts_collection'
require 'prompt/facts_collection'
require 'prompt/answers_collection'
require 'prompt/callout'

class Prompt
  attr_reader :step, :user_facts

  delegate :text, :token, :cta, :cta_class, :cta_href,
    :callout_url, :callout_body, :callout_method, :callout_success,
    :callout_failure_text, :callout_failure_cta, to: :step

  def initialize(step:, user_facts:)
    @step = step
    @user_facts = user_facts
    Rails.logger.info "Executing step: #{step.token}"
  end

  def save
    to_h
  end

  def to_h
    facts
    @hsh ||= begin
      hsh = { token: token }
      if @callout_successful
        Rails.logger.info 'Callout successful'
        hsh.merge!(text: text)
        hsh.merge!(cta: cta) if cta
        hsh.merge!(cta_class: cta_class) if cta_class
        hsh.merge!(cta_href: cta_href) if cta_href
      else
        Rails.logger.info 'Callout not successful'
        hsh.merge!(text: callout_failure_text)
        hsh.merge!(cta: callout_failure_cta)
        hsh.merge!(cta_class: cta_class) if cta_class
      end
      hsh[:parts] = PartsCollection.new(hsh[:text], answers(text: hsh[:text]), facts).to_a
      hsh
    end
  end

  def answers(text:)
    @answers ||= AnswersCollection.new(step: step, text: text, facts: facts).to_h
  end

  def facts
    @facts ||= begin
      if callout_url.present?
        callout = Callout.new(url: callout_url,
                              method: callout_method,
                              body: callout_body,
                              success: callout_success,
                              facts: user_facts)
        user_facts.merge!(callout.make)
      end
      @callout_successful = callout ? callout.successful? : true
      user_facts
    end
  end
end
