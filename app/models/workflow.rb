class Workflow < ActiveRecord::Base
  belongs_to :account
  has_many :steps
  has_many :answers
  has_many :options

  validates :name, presence: true
  validates :token, presence: true

  before_validation do
    self.token ||= SecureRandom.hex(8)
    self.name ||= token
  end

  def match(data)
    matched_step = steps.find { |step| step.match?(data) }
    return matched_step if matched_step
    raise UnmatchableDataError
  end

  class UnmatchableDataError < StandardError; end

  def to_h
    {
      token: token
    }
  end

  def to_param
    token
  end
end
