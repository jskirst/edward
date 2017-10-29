Cucumber::Persona.define "Developer Alpha" do
  account = Account.create!(api_key: "ABCDE")
  workflow = account.workflows.create!(token: "okayflow")
  workflow.steps.create!(token: 'okaystep', text: "okay text", conditions: "hmm=")
  workflow.answers.create!(token: "okayanswer", name: 'okayanswer', input_type: 'short_text', text_field_type: 'text', mask: '###')
  workflow.options.create!(token: 'okayoption', text: 'Yes', value: 'yes')
end

Cucumber::Persona.define "Developer Omega" do
  account = Account.create!(api_key: "XYZ")
  workflow = account.workflows.create!(token: "betterflow")
  workflow.steps.create!(token: 'betterstep', text: "Hmm!", conditions: "nothing=")
  workflow.answers.create!(token: 'betteranswer', name: 'betteranswer', input_type: 'short_text', text_field_type: 'text', mask: '###')
  workflow.options.create!(token: 'betteroption', text: 'Yes', value: 'yes')
end
