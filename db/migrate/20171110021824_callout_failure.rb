class CalloutFailure < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :callout_success, :string
    add_column :steps, :callout_failure_text, :text
    add_column :steps, :callout_failure_cta, :string
  end
end
