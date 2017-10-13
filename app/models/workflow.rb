class Workflow < ActiveRecord::Base
  has_many :steps
  has_many :answers

  before_create do
    self.token ||= SecureRandom::hex(8)
  end

  def match(data)
    steps.find { |step| step.match?(data) }
  end
end

