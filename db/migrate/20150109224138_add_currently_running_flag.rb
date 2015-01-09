class AddCurrentlyRunningFlag < ActiveRecord::Migration
  def change
    add_column :prediction_results, :currently_running, :boolean, default: false
  end
end
