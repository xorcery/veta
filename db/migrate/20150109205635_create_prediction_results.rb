class CreatePredictionResults < ActiveRecord::Migration
  def change
    create_table :prediction_results do |t|
      t.datetime :month
      t.float :maximum
      t.float :minimum
      t.float :upper_quartile
      t.float :lower_quartile
      t.float :median
      t.timestamps
    end
  end
end
