class MonthRangeWorker
  include Sidekiq::Worker

  def perform(result_id)

    @random_number_generator = Random.new

    result = PredictionResult.find(result_id)
    result.currently_running = true
    result.save!

    month = result.month
    current_and_future_projects = Project.where("start_on >= ?", month)
    pipeline_projects = current_and_future_projects.where(stage: 'Won')
    backlog_projects = current_and_future_projects.where("stage <> 'Won'")

    #filter down to active projects
    pipeline_projects.select! { |project| project.start_on.advance(months: project.months) <= month }
    backlog_projects.select! {|project| project.backlog_for_month(month).percent_complete.to_f > 0.0 }

    backlog_amount = backlog_amount_for_projects(backlog_projects, month)
    pipeline_predictions = pipeline_predictions_for_projects(pipeline_projects, month)

    #add the backlog_amount to all of the pipeline predictions
    amount_predictions = pipeline_predictions.map { |prediction| prediction + backlog_amount }.sort

    #calculate the median, upper and lower quartile and min/max
    result.minimum = amount_predictions.first
    result.maximum = amount_predictions.last
    result.median = amount_predictions[amount_predictions.length / 2]
    result.lower_quartile = amount_predictions[amount_predictions.length / 4]
    result.upper_quartile = amount_predictions[(amount_predictions.length * 3.0 / 4).to_i]

    result.currently_running = false
    result.save!

  end

  protected

  def backlog_amount_for_projects(projects, month)
    projects.inject(0) { |sum, project| sum + backlog_amount_for_project(project, month) }
  end

  def backlog_amount_for_project(project, month)
    backlog_month = project.backlog_for_month(month)
    if backlog_month.present? and backlog_month.percent_complete.to_f > 0
      #get the percent difference from the prior month
      prior_month = project.backlog_for_month(month.advance(months: -1))
      if prior_month.present? and prior_month.percent_complete.to_f > 0
        (backlog_month.percent_complete - prior_month.percent_complete) * project.gross_contract
      else
        backlog_month.percent_complete * project.gross_contract
      end
    else
      0
    end
  end

  def pipeline_predictions_for_projects(projects, month)
    predictions = []
    10000.times do |index| #run randomized prediction generation 10000 times for Monte Carlo
      prediction = projects.inject(0) {|sum, project| sum + pipeline_prediction_for_project(projects, month) }
      predictions << prediction
    end

    predictions

  end

  def pipeline_prediction_for_project(project, month)
    #only roll probability if the month is in the project
    if month >= project.start_on and month <= month.advance(months: project.months)
      #roll the dice on the probability of the project and if we hit it then return
      #the contract divided by number of months
      if @random_number_generator.rand < project.probability
        project.consulting_revenue / project.months
      else
        0
      end
    else
      0
    end

  end

end