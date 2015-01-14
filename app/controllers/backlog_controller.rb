class BacklogController < ApplicationController

  before_filter :authenticate_user!

  def index
    @backlog_entries = Project.backlog.includes(:backlog_months)
    @backlog_owners = backlog_owners.invert
    @months = []
    start_date = DateTime.now.beginning_of_month.advance(months: -6)
    20.times do |offset|
      @months << start_date.advance(months: offset)
    end
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
    {}.tap{ |h| User.all.each{ |u| h[u.select_name] = u.id } }
  end

end
