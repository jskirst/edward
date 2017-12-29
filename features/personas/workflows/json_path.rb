Cucumber::Persona.define "Json Path" do
  wf = Workflow.find_or_create_by(token: 'jsonpath', account: Account.create!)
  Step.create!(token: "jsonpath",
               workflow: wf,
               text: "Today's weather is {{$.weather.days[0].summary}}.",
               callout: 'https://www.weather.com',
               callout_method: 'get',
               conditions: "thing=")
end
