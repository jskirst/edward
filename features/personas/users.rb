Cucumber::Persona.define "Ben Franklin" do
  account = Account.create!
  User.create!(email: 'ben@franklin.com', password: 'Password1', account: account)
  wf = account.workflows.create!(token: 'okayworkflow', name: 'okayworkflow')
  wf.steps.create!(text: "Are you okay?", conditions: "hmm=")
  wf.answers.create!(token: 'goodanswer', name: "goodanswer", input_type: "short_text", text_field_type: "text")
  select = wf.answers.create!(token: 'selectanswer', name: "selectanswer", input_type: "select")
  yes = wf.options.create!(value: 'yes', text: 'Yes!')
  select.options << yes
  wf.options.create!(value: 'huh', text: 'Huh?')
end

Cucumber::Persona.define "Martha Washington" do
  account = Account.create!
  User.create!(email: 'martha@washington.com', password: 'Password1', account: account)
  wf = account.workflows.create!(token: 'bestworkflow', name: 'bestworkflow')
  wf.steps.create!(text: "I am okay?", conditions: "hmm=")
  wf.answers.create!(token: 'bestanswer', name: "bestanswer", input_type: "short_text", text_field_type: "text")
  wf.options.create!(value: 'yes', text: 'Huzzah!')
end
