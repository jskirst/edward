class Api::AnswersController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :workflow, foreign_key: :token
  lookup_param :token
  attr_permitted :name, :input_type, :text_field_type, :default_value,
                 :characters, :mask, :duplicate_answer_token
end
