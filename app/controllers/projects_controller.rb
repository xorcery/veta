class ProjectsController < ApplicationController

  respond_to :html, :json
  
  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    respond_with_bip @project
  end

  protected

  def project_params
    params.require(:project).permit!
  end

end
