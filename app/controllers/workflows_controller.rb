class WorkflowsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  belongs_to :account, getter: :current_user_account

  lookup_param :token
  attr_permitted :name, :duplicate_workflow_token

  private

  def current_user_account
    current_user.account
  end
end
