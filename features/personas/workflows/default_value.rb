Cucumber::Persona.define "Default Value" do
  wf = Workflow.find_or_create_by(token: 'defaultvalue', account: Account.create!)
  Step.create!(token: "defaultvalue",
               workflow: wf,
               text: "Default.{{?default_value}}",
               conditions: "default_value=")
  Answer.create(name: 'default_value',
                input_type: 'hidden',
                default_value: 'true',
                workflow: wf)
end
