class AddDefaultValueToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :default_value, :text
  end
end
