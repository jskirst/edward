Cucumber::Persona.define "Abc" do
  wf = Workflow.create!(token: 'abc', account: Account.create!)
  wf.steps.create!(token: "intro", text: "My first name is {{?user_first_name}}, and my last name is {{?user_last_name}}, and I am {{?user_age[min=21][max=100]}} years old. Generally I prefer {{?user_style_preference}} wines.",
               conditions: URI.escape("user_first_name=&user_last_name=&user_style_preference="), cta: 'next')
  Answer.create!(workflow: wf, token: "user_first_name", name: "user_first_name", input_type: "short_text", characters: 8, text_field_type: 'text')
  Answer.create!(workflow: wf, token: "user_last_name", name: "user_last_name", input_type: "short_text", characters: 10, text_field_type: 'text')
  Answer.create!(workflow: wf, token: "user_age", name: "user_age", input_type: "short_text", characters: 3, text_field_type: 'number')
  red = wf.options.create!(token: "redoption", value: "red", text: "red")
  white = wf.options.create!(token: "whiteoption", value: "white", text: "white")
  answer = Answer.create!(workflow: wf, token: "user_style_preference", name: "user_style_preference",
                 input_type: "select")
  answer.options << red
  answer.options << white

  wf.steps.create!(text: "Hello {{@user_first_name}}, would you like any recommendations?\n{{?user_desires_recommendations}}",
                   token: "hello",
                   conditions: URI.escape("user_first_name!=&user_desires_recommendations="), cta: 'next')
  yes = wf.options.create!(token: 'yesoption', value: "yes", text: "Yes")
  no = wf.options.create!(token: 'nooption', value: "no", text: "No")
  answer = Answer.create!(workflow: wf, token: "user_desires_recommendations", name: "user_desires_recommendations",
                 input_type: "select")
  answer.options << yes
  answer.options << no


  wf.steps.create!(token: "finethen",
                   text: "Well, fine then.",
                   conditions: "user_desires_recommendations!=yes", cta: 'next')

  wf.steps.create!(token: "really",
                   text: "Really? Splendid! Superb. I recommend the {{@recommendation}}.",
                   callout: "http://www.callout.com/api/fact?user_first_name={{user_first_name}}",
                   callout_method: "get",
                   conditions: URI.escape("user_style_preference=white&user_desires_recommendations=yes"), cta: 'next')

  wf.steps.create!(token: "recommendation",
                   text: "I recommend the {{@recommendation}}.\n{{?recommendation}}",
                   cta: "next",
                   callout: "http://www.callout.com/api/fact?user_first_name={{user_first_name}}",
                   callout_method: "post",
                   callout_body: "preference={{user_style_preference}}",
                   conditions: URI.escape("user_style_preference=red&user_desires_recommendations=yes"))
  Answer.create!(workflow: wf, token: "recommendation", name: "recommendation", input_type: "hidden")
end
