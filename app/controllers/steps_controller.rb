class StepsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  resource_lookup_param :token
  resource_permitted_params [:text, :conditions, :cta, :cta_class, :cta_link, :callout, :callout_method, :callout_body]

  private

  def authority
    current_user.account
  end

  def after_create_path(resource)
    workflow_path(owner)
  end
  alias :after_update_path :after_create_path
end

