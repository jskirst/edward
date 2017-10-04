Cucumber::Persona.define "Ragnar Lothbrok" do
  Step.create!(text: "My first name is {{user_first_name}}, and my last name is {{user_last_name}}.",
               conditions: URI.escape("user_first_name=&user_last_name="))
  Answer.create!(name: "user_first_name", input_type: "short_text")
  Answer.create!(name: "user_last_name", input_type: "short_text")

  Step.create!(text: "Generally I prefer {{user_style_preference}} wines.",
               conditions: URI.escape("user_style_preference="))
  Answer.create!(name: "user_style_preference",
                 input_type: "select",
                 options_attributes: [
                   { value: "red", text: "red" },
                   { value: "white", text: "white" }
                 ])

  Step.create!(text: "Would you like any white wine recommendations?\n{{user_desires_recommendations}}",
               conditions: URI.escape("user_desires_recommendations="))
  Answer.create!(name: "user_desires_recommendations",
                 input_type: "select",
                 options_attributes: [
                   { value: "yes", text: "Yes" },
                   { value: "no", text: "No" }
                 ])

  Step.create!("text": "I recommend the Russian River Chardonnay.",
                conditions: URI.escape("user_style_preference=white&user_desires_recommendations=yes"))
end
