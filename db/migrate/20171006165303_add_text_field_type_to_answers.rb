class AddTextFieldTypeToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :text_field_type, :string
  end
end
