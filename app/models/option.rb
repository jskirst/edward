class Option < ActiveRecord::Base
  def to_h
    {
      value: value,
      text: text
    }
  end
end
