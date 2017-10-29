class Api::StepsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :workflow, foreign_key: :token
  lookup_param :token
  attr_permitted :token, :text, :conditions, :duplicate_step_token, :cta, :cta_class,
                 :cta_href, :callout, :callout_method, :callout_body
end
