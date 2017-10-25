class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :api_key, null: false
      t.timestamps
    end

    add_column :workflows, :account_id, :integer
  end
end
