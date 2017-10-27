class Api::WorkflowsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :account
  owner_lookup_param :api_key
  owner_lookup_field :api_key
  resource_lookup_param :token
  resource_permitted_params [:token, :duplicate_workflow_token]

  private

  def owner
    @authority
  end
end
