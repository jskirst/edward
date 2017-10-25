class Api::PromptsController < ApplicationController
  before_action :load_workflow

  rescue_from Workflow::UnmatchableDataError do |e|
    render json: { error: "No matching step found.", facts: fact_params.to_h }, status: 422
  end

  rescue_from Step::Parts::AnswerNotFound do |e|
    render json: { error: e }, status: 500
  end

  rescue_from Step::Answers::AnswerNotFound do |e|
    render json: { error: e }, status: 500
  end

  def create
    Rails.logger.info "New step request for workflow #{params[:workflow_id]}: #{fact_params}"
    step = @workflow.match(fact_params)
    render json: step.to_h(fact_params.to_h)
  end

  private

  def load_workflow
    @workflow = Workflow.find_by(token: params[:workflow_id])
    return if @workflow
    render json: { error: "Workflow not found" }, status: :not_found
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
