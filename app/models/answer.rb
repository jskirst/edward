class Answer < ActiveRecord::Base
  has_many :answers_options
  has_many :options, through: :answers_options
  belongs_to :workflow

  attr_accessor :duplicate_answer_token

  validates :name, presence: true

  before_validation do
    if duplicate_answer_token.present?
      @duplicate_answer = account.answers.find_by!(token: duplicate_answer_token)
      @duplicate_answer.to_h.each do |key, value|
        self.send("#{key}=", value) unless key == :options
      end
      self.name = 'copy_' + @duplicate_answer.name
    end
    self.token ||= SecureRandom::uuid()
  end

  after_create do
    if @duplicate_answer
      @duplicate_answer.options.each do |option|
        if option.workflow == workflow
          self.options << option
        else
          self.options << workflow.options.find_by!(duplicated_from_id: option.id)
        end
      end
    end
  end

  def account
    workflow.account
  end

  def to_param
    token
  end

  def to_h(user_facts = nil)
    @hsh ||= begin
      hsh = { name: name }

      if user_facts
        hsh[:type] = input_type if user_facts
        hsh[:value] = default_value if default_value
        value = user_facts[name]
        hsh[:value] = value if value
      else
        hsh[:input_type] = input_type unless user_facts
        hsh[:default_value] = default_value if default_value
      end
      hsh[:prefix] = prefix if prefix
      hsh[:suffix] = suffix if suffix
      hsh[:options] = Options.new(options).to_a if options.any?
      hsh[:characters] = characters if characters
      hsh[:text_field_type] = text_field_type if text_field_type
      hsh[:mask] = mask if mask
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
