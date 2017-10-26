class AnswersOption < ApplicationRecord
  belongs_to :answer
  belongs_to :option

  validate :answer_and_option_have_same_workflow

  private

  def answer_and_option_have_same_workflow
    raise "WTF" unless answer.workflow == option.workflow
  end
end

