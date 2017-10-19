class AddCtaToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :cta, :string
  end
end
