class AddPrefixesAndSuffixesToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :prefix, :string
    add_column :answers, :suffix, :string
  end
end
