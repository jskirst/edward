class Api::OptionsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :workflow, foreign_key: :token
  lookup_param :token
  attr_permitted :token, :text, :value
end
