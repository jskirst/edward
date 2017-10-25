class Account < ActiveRecord::Base
  has_many :workflows

  before_create do
    self.api_key ||= SecureRandom::uuid()
  end
end
