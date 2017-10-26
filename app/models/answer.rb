class Answer < ActiveRecord::Base
  has_many :answers_options
  has_many :options, through: :answers_options
  belongs_to :workflow

  validates :name, presence: true

  def to_param
    name
  end

  def to_h(user_facts = nil)
    @hsh ||= begin
      hsh = {
        name: name,
      }
      hsh[:input_type] = input_type unless user_facts
      hsh[:type] = input_type if user_facts
      user_facts ||= {}
      hsh[:options] = Options.new(options).to_a if options.any?
      hsh[:characters] = characters if characters
      hsh[:text_field_type] = text_field_type if text_field_type
      hsh[:mask] = mask if mask
      value = user_facts[name]
      hsh[:value] = default_value if default_value
      hsh[:value] = value if value
      hsh
    end
  end

  class Options
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def to_a
      options.map(&:to_h)
    end
  end
end
