class ProjectBacklogMonth < ActiveRecord::Base

  has_paper_trail

  belongs_to :project

  validates :percent_complete, numericality: true, allow_nil: true

  default_scope { order('month asc') } 

end
