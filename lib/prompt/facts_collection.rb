class FactsCollection
  attr_reader :text, :user_facts, :callout, :callout_method, :callout_body

  def initialize(text, user_facts, callout, callout_method, callout_body)
    @text = text
    @user_facts = user_facts
    @callout = callout
    @callout_method = callout_method
    @callout_body = callout_body
    if callout.present?
      Rails.logger.info "Calling out to: #{callout}"
      @callout_facts = make_callout
    end
  end

  def to_h
    user_facts.merge(@callout_facts || {})
  end

  def make_callout
    return unless callout
    url_template = Liquid::Template.parse(callout)
    url = url_template.render(user_facts)
    if callout_method == "get"
      HTTParty.get(url).parsed_response.symbolize_keys
    else
      body_template = Liquid::Template.parse(callout_body)
      body = body_template.render(user_facts)

      HTTParty.post(url, { body: body }).parsed_response&.symbolize_keys
    end
  end
end

