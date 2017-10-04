class AddSizeToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :characters, :integer
  end
end
