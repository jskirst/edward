require 'rapido'

class Api::ApplicationController < ApplicationController
  include Rapido::Auth::ApiKey
end
