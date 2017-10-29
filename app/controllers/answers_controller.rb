class AnswersController < ApplicationController
  belongs_to :workflow, foreign_key: :token
  lookup_param :token
  attr_permitted :name, :input_type, :text_field_type, :default_value,
                 :characters, :mask, :duplicate_answer_token

  private

  def after_create_path(*)
    workflow_path(owner)
  end
  alias :after_update_path :after_create_path
  alias :after_delete_path :after_create_path
end
