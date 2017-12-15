require 'securerandom'

class Step < ActiveRecord::Base
  belongs_to :workflow

  attr_accessor :duplicate_step_token

  validates :text, presence: true
  validates :conditions, presence: true

  before_validation do
    if duplicate_step_token.present?
      duplicate_step = account.steps.find_by!(token: duplicate_step_token)
      duplicate_step.to_h.each do |key, value|
        self.send("#{key}=", value)
      end
      self.token = nil
      self.text = 'Copy - ' + duplicate_step.text
    end
  end

  before_save do
    self.token ||= SecureRandom.uuid
  end

  def account
    workflow.account
  end

  def match?(data)
    URI.unescape(conditions)
       .split('&')
       .all? do |f|
         if f.include?("=")
           key, value = f.split("=")
           if key.ends_with?('!')
             data[key[0..-2]].to_s != value.to_s
           else
             data[key].to_s == value.to_s
           end
         elsif f.include?(">")
           key, value = f.split(">")
           data[key].to_i > value.to_i
         elsif f.include?("<")
           key, value = f.split("<")
           data[key].to_i < value.to_i
         else
           raise "Bad comparator: #{f}"
         end
       end
  end

  def callout_url
    callout
  end

  def to_h
    {
      token: token,
      text: text,
      conditions: conditions,
      cta: cta,
      cta_class: cta_class,
      cta_href: cta_href,
      callout: callout_url,
      callout_method: callout_method,
      callout_body: callout_body
    }
  end

  def to_param
    token
  end
end
