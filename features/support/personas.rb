Cucumber::Persona.define "Ragnar Lothbrok" do
  wf = Workflow.create!(token: 'abc')
  wf.steps.create!(text: "My first name is {{?user_first_name}}, and my last name is {{?user_last_name}}, and I am {{?user_age}} years old. Generally I prefer {{?user_style_preference}} wines.",
               conditions: URI.escape("user_first_name=&user_last_name=&user_style_preference="))
  Answer.create!(name: "user_first_name", input_type: "short_text", characters: 8, text_field_type: 'text')
  Answer.create!(name: "user_last_name", input_type: "short_text", characters: 10, text_field_type: 'text')
  Answer.create!(name: "user_age", input_type: "short_text", characters: 3, text_field_type: 'number')
  Answer.create!(name: "user_style_preference",
                 input_type: "select",
                 options_attributes: [
                   { value: "red", text: "red" },
                   { value: "white", text: "white" }
                 ])

  wf.steps.create!(text: "Hello {{@user_first_name}}, would you like any recommendations?\n{{?user_desires_recommendations}}",
               conditions: URI.escape("user_desires_recommendations="))
  Answer.create!(name: "user_desires_recommendations",
                 input_type: "select",
                 options_attributes: [
                   { value: "yes", text: "Yes" },
                   { value: "no", text: "No" }
                 ])

  wf.steps.create!(text: "Really? Splendid! Superb. I recommend the {{@recommendation}}.",
                   callout: "http://www.callout.com/api/fact?user_first_name={{user_first_name}}",
                   callout_method: "get",
                   conditions: URI.escape("user_style_preference=white&user_desires_recommendations=yes"))

  wf.steps.create!(text: "I recommend the {{@recommendation}}.\n{{?recommendation}}",
                   callout: "http://www.callout.com/api/fact?user_first_name={{user_first_name}}",
                   callout_method: "post",
                   callout_body: "preference={{user_style_preference}}",
                   conditions: URI.escape("user_style_preference=red&user_desires_recommendations=yes"))
  Answer.create!(name: "recommendation", input_type: "hidden")
end
