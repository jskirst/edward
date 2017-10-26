class Option < ActiveRecord::Base
  has_and_belongs_to_many :answers
  belongs_to :workflow

  validates :text, presence: true
  validates :value, presence: true

  before_validation do
    self.token ||= SecureRandom.uuid
  end

  def name
    "#{text} / #{value}"
  end

  def to_h
    {
      value: value,
      text: text
    }
  end

  def key
    to_h.keys
  end

  def to_param
    token
  end
end
