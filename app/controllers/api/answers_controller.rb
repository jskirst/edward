class Api::AnswersController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :workflow
  owner_lookup_param :workflow_token
  owner_lookup_field :token

  resource_lookup_param :token
  resource_permitted_params %i[name input_type text_field_type mask
                               default_value characters duplicate_answer_token
                               prefix suffix]
end
