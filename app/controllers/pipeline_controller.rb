class PipelineController < ApplicationController

  before_filter :authenticate_user!

  def index
    @pipeline_entries = Project.pipeline
    @pipeline_owners = pipeline_owners.invert
  end

  def new
    @project = Project.new
    @pipeline_owners = pipeline_owners
  end

  def create
    @project = Project.new(project_params)
    @pipeline_owners = pipeline_owners

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

  def pipeline_owners
    {}.tap{ |h| User.all.each{ |u| h[u.select_name] = u.id } }
  end
  
end
