Cucumber::Persona.define "Ben Franklin" do
  account = Account.create!
  User.create!(email: 'ben@franklin.com', password: 'Password1', account: account)
  wf = account.workflows.create!(token: 'okayworkflow', name: 'okayworkflow')
  wf.steps.create!(text: "Are you okay?", conditions: "hmm=")
  wf.answers.create!(name: "goodanswer", input_type: "short_text", text_field_type: "text")
  wf.options.create!(value: 'yes', text: 'Yes!')
end

Cucumber::Persona.define "Martha Washington" do
  account = Account.create!
  User.create!(email: 'martha@washington.com', password: 'Password1', account: account)
  wf = account.workflows.create!(token: 'bestworkflow', name: 'bestworkflow')
  wf.steps.create!(text: "I am okay?", conditions: "hmm=")
  wf.answers.create!(name: "bestanswer", input_type: "short_text", text_field_type: "text")
  wf.options.create!(value: 'yes', text: 'Huzzah!')
end
