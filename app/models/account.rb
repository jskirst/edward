class Account < ActiveRecord::Base
  has_many :workflows
  has_many :users

  has_many :answers, through: :workflows
  has_many :options, through: :workflows
  has_many :steps, through: :workflows

  before_create do
    self.api_key ||= SecureRandom.uuid
  end
end
