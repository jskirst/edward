class AnswersOptionsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  owner_class :answer
  owner_lookup_param :answer_name
  owner_lookup_field :name

  resource_permitted_params [:option_id]

  private

  def after_create_path(*)
    edit_workflow_answer_path(owner.workflow, owner)
  end
  alias :after_delete_path :after_create_path
end
