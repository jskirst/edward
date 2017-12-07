Cucumber::Persona.define "Choices" do
  wf = Workflow.find_or_create_by(token: 'choices', account: Account.create!)
  Step.create!(token: "choices",
               workflow: wf,
               text: "Choices! {{!'This is choice one.'[facts=one%3Dtrue]}}\n {{!'This is choice two.'[facts=two%3Dtrue]}}",
               conditions: "one=&two=")

  wf.answers.create!(token: 'one',
                     name: 'one',
                     input_type: 'hidden')

  wf.answers.create!(token: 'two',
                     name: 'two',
                     input_type: 'hidden')

  Step.create!(token: "one",
               workflow: wf,
               text: "You selected choice 1. {{!'Go to choice 2?'[facts=one%3Dfalse&two%3Dtrue]}}",
               conditions: "one=true&two!=true")

  Step.create!(token: "two",
               workflow: wf,
               text: "You selected choice 2. {{!'Go to choice 1?'[facts=one%3Dtrue&two%3Dfalse]}}",
               conditions: "one!=true&two=true")
end
