class StepsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  belongs_to :workflow, foreign_key: :token
  lookup_param :token
  attr_permitted :text, :conditions, :duplicate_step_token, :cta, :cta_class,
                 :cta_href, :callout, :callout_method, :callout_body

  private

  def after_create_path(resource)
    workflow_path(owner)
  end
  alias :after_update_path :after_create_path
  alias :after_delete_path :after_create_path
end

