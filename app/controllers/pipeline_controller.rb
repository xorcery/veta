class PipelineController < ApplicationController

  def index
    @pipeline_entries = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to pipeline_index_path
    else
      render 'new'
    end

  end

  protected

  def project_params
    params.require(:project).permit!
  end
  
end
