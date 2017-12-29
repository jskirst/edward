Cucumber::Persona.define "Embedded Link" do
  wf = Workflow.find_or_create_by(token: 'embeddedlink', account: Account.create!)
  Step.create!(token: "embeddedlink",
               workflow: wf,
               text: "This {{#'is a link'[href=/#stepBack]}}",
               conditions: "link1=true")

  Step.create!(token: "clickforward",
               workflow: wf,
               text: "Click{{#'forward'[href=#][click=step_forward]}}{{?forward=true}}",
               conditions: "forward=")

  wf.answers.create!(token: 'forward',
                     name: 'forward',
                     input_type: 'hidden')

  Step.create!(token: "clickback",
               workflow: wf,
               text: "Click{{#'back'[href=#][click=step_back]}}",
               conditions: "forward=true")
end
