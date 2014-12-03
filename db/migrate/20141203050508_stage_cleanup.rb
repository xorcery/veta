class StageCleanup < ActiveRecord::Migration
  def change
    remove_column :projects, :stage
    rename_column :projects, :current_state, :stage
  end
end
