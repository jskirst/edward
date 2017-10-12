class AddMaskToTextFields < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :mask, :string
  end
end
