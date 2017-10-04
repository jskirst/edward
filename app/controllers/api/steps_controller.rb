class Api::StepsController < ApplicationController
  def create
    render json: workflow.match(fact_params).to_h(fact_params.to_h)
  end

  private

  def workflow
    @workflow ||= Workflow.find_by(token: params[:workflow_id])
  end

  def fact_params
    params[:facts].present? ? params.require(:facts).permit! : {}
  end

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
