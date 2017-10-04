class AddCalloutToStep < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :callout, :text
  end
end
