class Api::StepsController < Api::ApplicationController
  include Rapido::Controller

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  resource_lookup_param :token
  resource_permitted_params [:token, :text, :conditions, :callout, :callout_method, :callout_body]

end
