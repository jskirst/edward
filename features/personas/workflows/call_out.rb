Cucumber::Persona.define "Call Out" do
  wf = Workflow.create!(token: 'callout', account: Account.create!)
  wf.steps.create!(token: "guess", text: "Pick a number.\n{{?number}}",
               conditions: "number=&present=", cta: 'Guess')
  Answer.create!(workflow: wf, token: "number", name: "number", input_type: "short_text", characters: 3, text_field_type: 'text', mask: "#")

  wf.steps.create!(token: "result",
                   text: "You got it!Secret: {{$..secret[:0].value}}",
                   callout: "http://www.callout.com/number?number={{number}}",
                   callout_method: "get",
                   conditions: 'number!=',
                   callout_success: "$..secret[?(@['value'] == 123)]",
                   callout_failure_text: "Wrong!{{@error}}\n{{?number}}",
                   callout_failure_cta: "Guess Again"
                  )

  if Rails.env.test?
    stub_request(:get, "http://www.callout.com/number?number=1")
      .to_return(status: 200, body: '{"secret": [{ "value": 123}] }', headers: { 'Content-Type' => "application/json" })

    stub_request(:get, /http:\/\/www.callout.com\/number\?number=[2-9]/)
      .to_return(status: 404, body: '{"error": "It was something else."}', headers: { 'Content-Type' => "application/json" })
  end

  wf.steps.create!(token: "present",
                   text: "Present! {{$..present}}",
                   callout: "http://www.callout.com/present?present={{present}}",
                   callout_method: "get",
                   conditions: 'present!=',
                   callout_success: "$..present[?(@['present'])]",
                   callout_failure_text: "Not present",
                   callout_failure_cta: "Oh well"
                  )

  if Rails.env.test?
    stub_request(:get, /http:\/\/www.callout.com\/present\?present=true/)
      .to_return(status: 200, body: '{"present": "And accounted for!"}', headers: { 'Content-Type' => "application/json" })

    stub_request(:get, /http:\/\/www.callout.com\/present\?present=false/)
      .to_return(status: 200, body: '{"notpresent": "true"}', headers: { 'Content-Type' => "application/json" })
  end
end
