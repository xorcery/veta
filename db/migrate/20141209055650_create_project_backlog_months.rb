class CreateProjectBacklogMonths < ActiveRecord::Migration
  def change
    create_table :project_backlog_months do |t|
      t.datetime :month
      t.float :percent_complete
      t.references :project
      t.timestamps
    end
  end
end
