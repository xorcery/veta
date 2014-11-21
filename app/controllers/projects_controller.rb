class ProjectsController < ApplicationController

  respond_to :html, :json
  
  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    respond_with @user
  end

  protected

  def project_params
    params.require(:project).permit(:client, :title, :comments, :project_type,
                                    :rfp, :new_client, :consulting_revenue, :other_revenue,
                                    :identified_on, :submitted_on, :lost_on, :start_date, :months)
  end

end
