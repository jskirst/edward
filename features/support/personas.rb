Cucumber::Persona.define "Ragnar Lothbrok" do
  wf = Workflow.create!(token: 'abc', account: Account.create!)
  wf.steps.create!(token: "intro", text: "My first name is {{?user_first_name}}, and my last name is {{?user_last_name}}, and I am {{?user_age}} years old. Generally I prefer {{?user_style_preference}} wines.",
               conditions: URI.escape("user_first_name=&user_last_name=&user_style_preference="))
  Answer.create!(workflow: wf, name: "user_first_name", input_type: "short_text", characters: 8, text_field_type: 'text')
  Answer.create!(workflow: wf, name: "user_last_name", input_type: "short_text", characters: 10, text_field_type: 'text')
  Answer.create!(workflow: wf, name: "user_age", input_type: "short_text", characters: 3, text_field_type: 'number')
  Answer.create!(workflow: wf, name: "user_style_preference",
                 input_type: "select",
                 options_attributes: [
                   { value: "red", text: "red" },
                   { value: "white", text: "white" }
                 ])

  wf.steps.create!(text: "Hello {{@user_first_name}}, would you like any recommendations?\n{{?user_desires_recommendations}}",
                   token: "hello",
                   conditions: URI.escape("user_first_name!=&user_desires_recommendations="))
  Answer.create!(workflow: wf, name: "user_desires_recommendations",
                 input_type: "select",
                 options_attributes: [
                   { value: "yes", text: "Yes" },
                   { value: "no", text: "No" }
                 ])

  wf.steps.create!(token: "finethen",
                   text: "Well, fine then.",
                   conditions: "user_desires_recommendations!=yes")

  wf.steps.create!(token: "really",
                   text: "Really? Splendid! Superb. I recommend the {{@recommendation}}.",
                   callout: "http://www.callout.com/api/fact?user_first_name={{user_first_name}}",
                   callout_method: "get",
                   conditions: URI.escape("user_style_preference=white&user_desires_recommendations=yes"))

  wf.steps.create!(token: "recommendation",
                   text: "I recommend the {{@recommendation}}.\n{{?recommendation}}",
                   callout: "http://www.callout.com/api/fact?user_first_name={{user_first_name}}",
                   callout_method: "post",
                   callout_body: "preference={{user_style_preference}}",
                   conditions: URI.escape("user_style_preference=red&user_desires_recommendations=yes"))
  Answer.create!(workflow: wf, name: "recommendation", input_type: "hidden")
end

Cucumber::Persona.define "New Line" do
  wf = Workflow.find_or_create_by(token: 'newline', account: Account.create!)
  Step.create!(token: "newline",
               workflow: wf,
               text: "Texting a token\nto your phone.",
               conditions: "newline=")
end

Cucumber::Persona.define "Callto Action" do
  wf = Workflow.find_or_create_by(token: 'cta', account: Account.create!)
  Step.create!(token: "hello",
               workflow: wf,
               text: "Hello.",
               conditions: "hmm=",
               cta: "Would you like to play a game?",
               cta_class: "this that",
               cta_href: "https://www.example.com")
end

Cucumber::Persona.define "Cannot Match" do
  wf = Workflow.find_or_create_by(token: 'cannotmatch', account: Account.create!)
  Step.create!(token: "impossible",
               workflow: wf,
               text: "Hello.",
               conditions: "impossible!=")
end

Cucumber::Persona.define "Nosuch Answer" do
  wf = Workflow.find_or_create_by(token: 'nosuchanswer', account: Account.create!)
  Step.create!(token: "impossible",
               workflow: wf,
               text: "Hello.{{?doesnotexist}}",
               conditions: "thing=")
end

Cucumber::Persona.define "Json Path" do
  wf = Workflow.find_or_create_by(token: 'jsonpath', account: Account.create!)
  Step.create!(token: "jsonpath",
               workflow: wf,
               text: "Today's weather is {{$.weather.days[0].summary}}.",
               callout: 'https://www.weather.com',
               callout_method: 'get',
               conditions: "thing=")
end

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

Cucumber::Persona.define "Default Value" do
  wf = Workflow.find_or_create_by(token: 'defaultvalue', account: Account.create!)
  Step.create!(token: "defaultvalue",
               workflow: wf,
               text: "Default.{{?default_value}}",
               conditions: "default_value=")
  Answer.create(name: 'default_value',
                input_type: 'hidden',
                default_value: 'true',
                workflow: wf)
end

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

Cucumber::Persona.define "Arthur Dent" do
  wf = Workflow.find_or_create_by(token: 'auth', account: Account.create!)

  Step.create!(token: "phone",
               workflow: wf,
               text: "Texting a token to your phone.\n{{?user_phone_number}}",
               conditions: "user_phone_number=")
  Answer.create!(workflow: wf,
                 name: "user_phone_number",
                 input_type: "short_text",
                 characters: 11,
                 text_field_type: 'number',
                 mask: "(###) ###-####")

  Step.create!(workflow: wf,
               token: "confirmation",
               text: "Please enter the 4 digit number that was just sent to your phone.\n{{?user_confirmation_token}}",
               conditions: "user_phone_number!=&user_confirmation_token=",
               callout: "https://www.callout.com/api/v1/users",
               callout_method: "post",
               callout_body: "user[phone={{user_phone_number}}]")
  Answer.create!(workflow: wf,
                 name: "user_confirmation_token",
                 input_type: "short_text",
                 characters: 6,
                 text_field_type: 'number',
                 mask: "####")

  Step.create!(workflow: wf,
               token: "thankyou",
               text: "Thank you! Welcome to the application.{{?auth_token}}",
               conditions: "user_confirmation_token!=&auth_token=",
               callout: "https://www.callout.com/api/v1/sessions",
               callout_method: "post",
               callout_body: "session[phone]={{phone}}&session[confirmation_token]={{user_confirmation_token}}")
  Answer.create!(workflow: wf,
                 name: "auth_token",
                 input_type: "hidden")
end
