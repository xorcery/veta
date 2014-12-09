class DifferentiateBacklogPipelineOwners < ActiveRecord::Migration
  def change
    rename_column :projects, :owner_id, :pipeline_owner_id
    add_column :projects, :backlog_owner_id, :integer
  end
end
