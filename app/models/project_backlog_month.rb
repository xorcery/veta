class ProjectBacklogMonth < ActiveRecord::Base

  belongs_to :project

  default_scope { order('month asc') } 

end
