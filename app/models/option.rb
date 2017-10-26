class Option < ActiveRecord::Base
  has_many :answers_options
  has_many :options, through: :answers_options
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
