class BacklogController < ApplicationController

  def index
    @backlog_entries = Project.backlog
    @backlog_owners = backlog_owners.invert
  end

  def new
    @project = Project.new
    @backlog_owners = backlog_owners
  end

  def create
    @project = Project.new(project_params)
    @backlog_owners = backlog_owners

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

  def backlog_owners
    {}.tap{ |h| User.all.each{ |u| h[u.first_name] = u.id } }
  end

end
