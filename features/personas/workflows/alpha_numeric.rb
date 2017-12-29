Cucumber::Persona.define "Alpha Numeric" do
  wf = Workflow.find_or_create_by(token: 'alphanumeric', account: Account.create!)
  Step.create!(token: "alphanumeric",
               workflow: wf,
               text: "Letter.{{?alpha_1}}",
               conditions: "thing=")
  Answer.create(name: 'alpha_1',
                input_type: 'hidden',
                workflow: wf)
end

