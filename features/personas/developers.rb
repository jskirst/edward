Cucumber::Persona.define "Andy Developer" do
  account = Account.create!(api_key: "ABCDE")
  workflow = account.workflows.create!(token: "okayflow")
  workflow.steps.create!(token: 'okaystep', text: "okay text", conditions: "hmm=")
  workflow.answers.create!(name: 'okayanswer', input_type: 'short_text', text_field_type: 'text', mask: '###')
end

Cucumber::Persona.define "Betsy Developer" do
  account = Account.create!(api_key: "XYZ")
  workflow = account.workflows.create!(token: "betterflow")
  workflow.steps.create!(token: 'betterstep', text: "Hmm!", conditions: "nothing=")
  workflow.answers.create!(name: 'betteranswer', input_type: 'short_text', text_field_type: 'text', mask: '###')
end
