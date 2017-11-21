class FactsCollection
  attr_reader :text, :user_facts, :callout, :callout_method, :callout_body, :callout_response, :callout_success

  def initialize(text, user_facts, callout, callout_method, callout_body, callout_success)
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
    url_template = Liquid::Template.parse(callout)
    url = url_template.render(user_facts)
    if callout_method == "get"
      @callout_response = HTTParty.get(url)
    else
      body_template = Liquid::Template.parse(callout_body)
      body = body_template.render(user_facts)
      @callout_response = HTTParty.post(url, { body: body })
    end
    @callout_facts = @callout_response.parsed_response&.symbolize_keys
    return callout_successful?
  end

  private

  def callout_successful?
    return true unless callout_success
    path = JsonPath.new(callout_success)
    path.on(@callout_facts.to_json).first.present?
  end
end

