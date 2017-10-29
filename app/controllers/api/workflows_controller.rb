class Api::WorkflowsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :account, getter: :authority
  lookup_param :token
  attr_permitted :token, :name, :duplicate_workflow_token
end
