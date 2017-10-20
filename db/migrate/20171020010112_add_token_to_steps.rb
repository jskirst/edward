class AddTokenToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :token, :string
  end
end
