class ChangelogsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @changes = @project.versions.order("created_at desc").map do |version|
      user = User.find(version.whodunnit)

      if version.event == 'create'
        "Created by #{user.select_name}"
      else
        changeset = version.changeset
        changeset.delete("updated_at")
        changes = changeset.map {|key, value| "#{key.humanize} to #{value.last}"}

        "#{user.select_name} changed #{changes.join(', ')}"
      end

    end
  end

end
