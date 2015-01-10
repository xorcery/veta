require 'sidekiq/api'

class ProbabilityRangeWorker
  include Sidekiq::Worker

  def perform
    Sidekiq::Queue.new.clear #clear all current sidekiq jobs

    #kick off a worker for each forward month from the current
    start_date = DateTime.now.beginning_of_month
    12.times.each do |offset|
      month = start_date.advance(months: offset)
      result = PredictionResult.find_or_create_by(month: month)
      MonthRangeWorker.perform_async(result.id)
    end

  end

end