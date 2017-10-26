class OptionsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  resource_lookup_param :token
  resource_permitted_params [:text, :value]

  private

  def after_create_path(*)
    workflow_path(owner)
  end
  alias :after_update_path :after_create_path
  alias :after_delete_path :after_create_path
end
