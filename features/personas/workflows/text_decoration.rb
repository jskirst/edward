Cucumber::Persona.define "Text Decoration" do
  wf = Workflow.find_or_create_by(token: 'textdecoration', account: Account.create!)
  Step.create!(token: "bold",
               workflow: wf,
               text: "I am **bold.",
               conditions: "bold=true")
end
