require 'prompt'

class Api::PromptsController < ActionController::API
  include Rapido::Controller
  include Rapido::ApiController

  rescue_from Prompt::Factory::UnmatchableDataError do |e|
    render json: { error: e }, status: 422
  end

  rescue_from Prompt::PartsCollection::AnswerNotFound do |e|
    render json: { error: e }, status: 500
  end

  rescue_from Prompt::AnswersCollection::AnswerNotFound do |e|
    render json: { error: e }, status: 500
  end

  rescue_from Rapido::Errors::RecordNotFound do |_e|
    render json: { error: 'Workflow not found.' }, status: 404
  end

  belongs_to :workflow, foreign_key: :token

  free_from_authority!
  permit_all_params!
end
