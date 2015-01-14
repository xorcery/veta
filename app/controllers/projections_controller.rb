class ProjectionsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @prediction_results = PredictionResult.where("month >= ?",Time.now.beginning_of_month).
                                            order("month asc").limit(4)
    @series_labels = @prediction_results.map {|result| result.month.strftime('%b %y')}
    puts @series_labels
    @series_data = @prediction_results.map do |result| 
      [
        result.minimum, 
        result.lower_quartile, 
        result.median, 
        result.upper_quartile, 
        result.maximum
      ].map {|value| value.round(2) }
    end
  end

end
