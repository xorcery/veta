class MonthRangeWorker
  include Sidekiq::Worker

  def perform(result_id)
    result = PredictionResult.find(result_id)
    result.currently_running = true
    result.save!

    

    
  end

end