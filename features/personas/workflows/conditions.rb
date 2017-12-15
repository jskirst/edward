Cucumber::Persona::define "Conditions" do
  wf = Workflow.find_or_create_by(token: 'conditions', account: Account.create!)
  Step.create!(token: "blank",
               workflow: wf,
               text: "Count is: blank.\n{{!'Add 1.'[facts=count%3D1]}}",
               conditions: "count=")
  Step.create!(token: "equals",
               workflow: wf,
               text: "Count is: {{@count}}\n{{!'Add 1.'[facts=count%3D2]}}",
               conditions: "count=1")
  Step.create!(token: "greaterthen",
               workflow: wf,
               text: "Count is: {{@count}}",
               conditions: "count>1")
end
