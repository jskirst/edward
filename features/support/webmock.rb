require 'webmock'
include WebMock::API

unless ENV['DISABLE_WEBMOCK'] == 'true'
  WebMock.enable!
end

stub_request(:get, "http://www.callout.com/api/fact?user_first_name=Giles")
  .with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'})
  .to_return(status: 200, body: '{"recommendation": "Russian River Chardonnay"}', headers: { 'Content-Type' => "application/json" })

