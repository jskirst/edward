Cucumber::Persona.define "Nosuch Answer" do
  wf = Workflow.find_or_create_by(token: 'nosuchanswer', account: Account.create!)
  Step.create!(token: "impossible",
               workflow: wf,
               text: "Hello.{{?doesnotexist}}",
               conditions: "thing=")
end

