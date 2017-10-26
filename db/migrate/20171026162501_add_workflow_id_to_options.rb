class AddWorkflowIdToOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :workflow_id, :integer
    add_column :options, :token, :string
  end
end
