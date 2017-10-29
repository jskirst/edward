class Option < ActiveRecord::Base
  has_many :answers_options
  has_many :options, through: :answers_options
  belongs_to :workflow

  attr_accessor :duplicate_option_token

  validates :text, presence: true
  validates :value, presence: true

  before_validation do
    if duplicate_option_token
      @duplicate_option = account.options.find_by!(token: duplicate_option_token)
      self.text = @duplicate_option.text
      self.value = @duplicate_option.value
      self.duplicated_from_id = @duplicate_option.id
    end
    self.token ||= SecureRandom.uuid
  end

  def account
    workflow.account
  end

  def name
    "#{text} / #{value}"
  end

  def to_h
    {
      token: token,
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
