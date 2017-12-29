Cucumber::Persona.define "Default Textvalue" do
  wf = Workflow.find_or_create_by(token: 'defaulttextvalue', account: Account.create!)
  Step.create!(token: "defaulttextvalue",
               workflow: wf,
               text: "Default.{{?default_text_value='false'}}",
               conditions: "default_text_value=")
  Answer.create(name: 'default_text_value',
                input_type: 'hidden',
                workflow: wf)
end
