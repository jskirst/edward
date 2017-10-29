class OptionsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  belongs_to :workflow, foreign_key: :token

  lookup_param :token
  attr_permitted :text, :value

  private

  def after_create_path(*)
    workflow_path(owner)
  end
  alias :after_update_path :after_create_path
  alias :after_delete_path :after_create_path
end
