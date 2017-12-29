Cucumber::Persona.define "Cta" do
  wf = Workflow.find_or_create_by(token: 'cta', account: Account.create!)
  Step.create!(token: "hello",
               workflow: wf,
               text: "Hello.",
               conditions: "hmm=",
               cta: "Would you like to play a game?",
               cta_class: "this that",
               cta_href: "https://www.example.com")
end
