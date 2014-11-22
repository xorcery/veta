class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :current_state
      t.string :client
      t.string :code
      t.float :gross_contract
      t.string :title
      t.string :project_type
      t.boolean :rfp
      t.boolean :new_client
      t.references :owner
      t.float :other_revenue
      t.float :consulting_revenue
      t.float :stage
      t.date :identified_on
      t.date :submitted_on
      t.date :authorized_on
      t.date :lost_on
      t.text :comments
      t.float :probability
      t.date :start_on
      t.integer :months
      t.timestamps
    end
  end
end
