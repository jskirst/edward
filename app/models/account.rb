class Account < ActiveRecord::Base
  has_many :workflows
  has_many :users

  before_create do
    self.api_key ||= SecureRandom.uuid
  end
end
