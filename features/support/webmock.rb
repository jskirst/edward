require 'webmock'
include WebMock::API

unless ENV['DISABLE_WEBMOCK'] == 'true'
  WebMock.enable!
end

stub_request(:get, "http://www.callout.com/api/fact?user_first_name=Giles")
  .to_return(status: 200, body: '{"recommendation": "Russian River Chardonnay"}', headers: { 'Content-Type' => "application/json" })

stub_request(:post, "http://www.callout.com/api/fact?user_first_name=Giles")
  .with(body: 'preference=red')
  .to_return(status: 200, body: '{"recommendation": "Pinot Noir"}', headers: { 'Content-Type' => "application/json" })

stub_request(:post, "https://www.callout.com/api/v1/users")
  .to_return(status: 200)

stub_request(:post, "https://www.callout.com/api/v1/sessions")
  .to_return(status: 200, body: '{ "auth_token": "1234" }', headers: { 'Content-Type' => "application/json" })

stub_request(:get, "https://www.weather.com")
  .to_return(status: 200, body: '{"weather": { "days": [ { "summary": "sunny" } ] } }', headers: { 'Content-Type' => "application/json" })

