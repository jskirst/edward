class Answer < ActiveRecord::Base
  has_and_belongs_to_many :options

  accepts_nested_attributes_for :options

  def to_h
    @hsh ||= begin
      hsh = {
        type: input_type
      }
      hsh.merge!(options: Options.new(options).to_a) if options.any?
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
