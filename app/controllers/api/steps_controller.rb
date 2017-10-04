class Api::StepsController < ApplicationController
  def create
    render json: Step.match(params[:facts]).to_h(params[:facts])
  end

  private

  def step
    @step = {}
    @step[:text] = "My first name is [:user_first_name], and my last name is [:user_last_name]."
    @step[:answers] = {
      user_first_name: { input_type: "short_text" },
      user_last_name: { input_type: "short_text" }
    }
    @step
  end
end
