class CreateWorkflowTable < ActiveRecord::Migration[5.1]
  def change
    create_table :workflows do |t|
      t.string :token
      t.timestamps
    end

    add_column :steps, :workflow_id, :integer
    add_index :workflows, [:token], unique: true
  end
end
