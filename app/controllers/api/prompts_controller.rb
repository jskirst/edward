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

  rescue_from Rapido::Errors::RecordNotFound do |e|
    render json: { error: 'Workflow not found.' }, status: 404
  end

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  free_from_authority!
  permit_all_params!
end
