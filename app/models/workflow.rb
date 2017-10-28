class Workflow < ActiveRecord::Base
  belongs_to :account
  has_many :steps
  has_many :answers
  has_many :options

  attr_accessor :duplicate_workflow_token

  validates :name, presence: true
  validates :token, presence: true

  before_validation do
    if duplicate_workflow_token
      @duplicate_workflow = account.workflows.find_by!(token: duplicate_workflow_token)
      self.name = 'Copy - ' + @duplicate_workflow.name
    end
    self.token ||= SecureRandom.hex(8)
    self.name ||= token
  end

  after_create do
    if @duplicate_workflow
      @duplicate_workflow.options.each { |o| options.create!(duplicate_option_token: o.token) }
      @duplicate_workflow.steps.each { |s| steps.create!(duplicate_step_token: s.token) }
      @duplicate_workflow.answers.each { |a| answers.create!(duplicate_answer_token: a.token) }
    end
  end

  def prompts
    Prompt::Factory.new(self)
  end

  def to_h
    {
      token: token
    }
  end

  def to_param
    token
  end
end
