class BacklogController < ApplicationController

  def index
    @backlog_entries = Project.backlog
    @backlog_owners = {}.tap{ |h| User.all.each{ |u| h[u.id] = u.first_name } }
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to backlog_index_path
    else
      render 'new'
    end

  end

  protected

  def project_params
    params.require(:project).permit!
  end

end
