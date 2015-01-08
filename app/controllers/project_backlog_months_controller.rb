class ProjectBacklogMonthsController < ApplicationController

  respond_to :json
  
  def update
    @backlog_month = ProjectBacklogMonth.find(params[:id])
    @backlog_month.update_attributes(project_backlog_month_params)
    respond_with_bip @backlog_month
  end

  protected

  def project_backlog_month_params
    params.require(:project_backlog_month).permit!
  end

end
