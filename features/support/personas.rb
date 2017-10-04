Cucumber::Persona.define "Ragnar Lothbrok" do
  Step.create!(text: "My first name is {{?user_first_name}}, and my last name is {{?user_last_name}}. Generally I prefer {{?user_style_preference}} wines.",
               conditions: URI.escape("user_first_name=&user_last_name=&user_style_preference="))
  Answer.create!(name: "user_first_name", input_type: "short_text")
  Answer.create!(name: "user_last_name", input_type: "short_text")
  Answer.create!(name: "user_style_preference",
                 input_type: "select",
                 options_attributes: [
                   { value: "red", text: "red" },
                   { value: "white", text: "white" }
                 ])

  Step.create!(text: "Hello {{@user_first_name}}, would you like any recommendations?\n{{?user_desires_recommendations}}",
               conditions: URI.escape("user_desires_recommendations="))
  Answer.create!(name: "user_desires_recommendations",
                 input_type: "select",
                 options_attributes: [
                   { value: "yes", text: "Yes" },
                   { value: "no", text: "No" }
                 ])

  Step.create!("text": "I recommend the Russian River Chardonnay.",
                conditions: URI.escape("user_style_preference=white&user_desires_recommendations=yes"))

  Step.create!("text": "I recommend the Pinot Noir.",
                conditions: URI.escape("user_style_preference=red&user_desires_recommendations=yes"))
end
