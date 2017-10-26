Cucumber::Persona.define "Ben Franklin" do
  account = Account.create!
  User.create!(email: 'ben@franklin.com', password: 'Password1', account: account)
  wf = account.workflows.create!(token: 'okayworkflow', name: 'okayworkflow')
  wf.steps.create!(text: "Are you okay?", conditions: "hmm=")
end

Cucumber::Persona.define "Martha Washington" do
  account = Account.create!
  User.create!(email: 'martha@washington.com', password: 'Password1', account: account)
  account.workflows.create!(token: 'bestworkflow', name: 'bestworkflow')
end
