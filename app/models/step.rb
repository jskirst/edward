require 'securerandom'

class Step < ActiveRecord::Base
  belongs_to :workflow

  validates :text, presence: true
  validates :conditions, presence: true

  before_save do
    self.token ||= SecureRandom.uuid
  end

  def match?(data)
    URI.unescape(conditions)
       .split('&')
       .map { |c| c.split('=') }
       .all? do |key, value|
         if key.ends_with?('!')
           data[key[0..-2]].to_s != value.to_s
         else
           data[key].to_s == value.to_s
         end
       end
  end

  def to_h
    {
      token: token,
      text: text,
      conditions: conditions
    }
  end

  def to_param
    token
  end
end
