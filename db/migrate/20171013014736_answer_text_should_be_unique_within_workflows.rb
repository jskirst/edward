class AnswerTextShouldBeUniqueWithinWorkflows < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :workflow_id, :integer
    add_index :answers, [:workflow_id, :name], unique: true
    add_index :steps, [:workflow_id, :text], unique: true
  end
end
