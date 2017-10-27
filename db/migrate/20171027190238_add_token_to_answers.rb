class AddTokenToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :token, :string
  end
end
