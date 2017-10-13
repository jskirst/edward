class Answer < ActiveRecord::Base
  has_and_belongs_to_many :options
  belongs_to :workflow

  accepts_nested_attributes_for :options

  def to_h
    @hsh ||= begin
      hsh = {
        type: input_type
      }
      hsh.merge!(options: Options.new(options).to_a) if options.any?
      hsh.merge!(characters: characters) if characters
      hsh.merge!(text_field_type: text_field_type) if text_field_type
      hsh.merge!(mask: mask) if mask
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
