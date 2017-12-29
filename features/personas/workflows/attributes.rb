Cucumber::Persona.define "Attributes" do
  wf = Workflow.find_or_create_by(token: 'attributes', account: Account.create!)
  Step.create!(token: "favoritecolor",
               workflow: wf,
               text: "Favorite color?{{?color='blue'[min=100]}}",
               conditions: "color=&how_great=&hue=")

  wf.answers.create!(token: "color",
                     name: "color",
                     input_type: "short_text",
                     text_field_type: "text")

  Step.create!(token: "favoritehue",
               workflow: wf,
               text: "Favorite hue?{{?hue='200'[min=@hue]}}",
               conditions: "hue!=")

  wf.answers.create!(token: "hue",
                     name: "hue",
                     input_type: "short_text",
                     text_field_type: "text")

  Step.create!(token: "color",
               workflow: wf,
               text: "Color?{{@color[font-style=Times New Roman][bold=true]}}",
               conditions: "color!=")

  Step.create!(token: "attributes",
               workflow: wf,
               text: "How great?{{@how_great[bold=true]}}",
               conditions: "how_great!=")
end
