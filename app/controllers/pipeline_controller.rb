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
    params.require(:project).permit(:client, :title, :comments, :project_type,
                                    :rfp, :new_client, :consulting_revenue, :other_revenue,
                                    :identified_on, :submitted_on, :lost_on, :start_date, :months)
  end
  
end
