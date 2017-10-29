class AnswersOptionsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  belongs_to :answer, foreign_key: :token

  attr_permitted :option_id

  private

  def after_create_path(*)
    edit_workflow_answer_path(owner.workflow, owner)
  end
  alias :after_delete_path :after_create_path
end
