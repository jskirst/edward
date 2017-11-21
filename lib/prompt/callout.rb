class Callout
  attr_reader :method, :success, :facts, :url, :body

  def initialize(url:, method:, facts:, body: nil, success: nil)
    @url = url
    @method = method
    @body = body
    @success = success
    @facts = facts
  end

  def parsed_url
    Liquid::Template.parse(url).render(facts)
  end

  def parsed_body
    Liquid::Template.parse(body).render(facts)
  end

  def make
    if method == "get"
      @response = HTTParty.get(parsed_url)
    else
      @response = HTTParty.post(parsed_url, { body: parsed_body })
    end
    @parsed_response = @response.parsed_response&.symbolize_keys || {}
  end

  def successful?
    return true unless success
    path = JsonPath.new(success)
    path.on(@parsed_response.to_json).first.present?
  end
end
