class Api::StepsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  resource_lookup_param :token
  resource_permitted_params %i[token text conditions callout callout_method callout_body
                               cta cta_class cta_button]
end
