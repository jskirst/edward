Cucumber::Persona.define "Auth Example" do
  wf = Workflow.find_or_create_by(token: 'auth', account: Account.create!)

  Step.create!(token: "phone",
               workflow: wf,
               text: "Texting token.\n{{?user_phone_number}}",
               conditions: "user_phone_number=")
  Answer.create!(workflow: wf,
                 token: "user_phone_number", name: "user_phone_number",
                 input_type: "short_text",
                 characters: 11,
                 text_field_type: 'number',
                 mask: "(###) ###-####")

  Step.create!(workflow: wf,
               token: "confirmation",
               text: "Please enter code.\n{{?user_confirmation_token}}",
               conditions: "user_phone_number!=&user_confirmation_token=",
               callout: "https://www.callout.com/api/v1/users",
               callout_method: "post",
               callout_body: "user[phone={{user_phone_number}}]")
  Answer.create!(workflow: wf,
                 token: "user_confirmation_token", name: "user_confirmation_token",
                 input_type: "short_text",
                 characters: 6,
                 text_field_type: 'number',
                 mask: "####")

  Step.create!(workflow: wf,
               token: "thankyou",
               text: "Thank you!{{?auth_token}}",
               conditions: "user_confirmation_token!=&auth_token=",
               callout: "https://www.callout.com/api/v1/sessions",
               callout_method: "post",
               callout_body: "session[phone]={{phone}}&session[confirmation_token]={{user_confirmation_token}}")
  Answer.create!(workflow: wf,
                 token: "auth_token", name: "auth_token",
                 input_type: "hidden")
end
