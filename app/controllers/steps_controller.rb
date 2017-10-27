class StepsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  before_action do
    resource_permitted_params
  end

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  resource_lookup_param :token
  resource_permitted_params [:text, :conditions, :duplicate_step_token, :cta, :cta_class,
                             :cta_href, :callout, :callout_method, :callout_body]

  private

  def after_create_path(resource)
    workflow_path(owner)
  end
  alias :after_update_path :after_create_path
  alias :after_delete_path :after_create_path
end

