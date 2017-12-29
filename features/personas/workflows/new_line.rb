Cucumber::Persona.define "New Line" do
  wf = Workflow.find_or_create_by(token: 'newline', account: Account.create!)
  Step.create!(token: "newline",
               workflow: wf,
               text: "Texting a token\nto your phone.",
               conditions: "newline=")
end
