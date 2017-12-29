Cucumber::Persona.define "Cannot Match" do
  wf = Workflow.find_or_create_by(token: 'cannotmatch', account: Account.create!)
  Step.create!(token: "impossible",
               workflow: wf,
               text: "Hello.",
               conditions: "impossible!=")
end
