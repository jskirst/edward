class AddDuplicatedFromIdToOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :duplicated_from_id, :integer
  end
end
