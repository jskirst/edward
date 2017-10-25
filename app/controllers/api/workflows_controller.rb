class Api::WorkflowsController < Api::ApplicationController
  include Rapido::Controller

  owner_class :account
  owner_lookup_param :api_key
  owner_lookup_field :api_key
  resource_lookup_param :token
  resource_permitted_params [:token]

  private

  def owner
    @authority
  end
end

