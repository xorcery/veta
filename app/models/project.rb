class Project < ActiveRecord::Base

  has_paper_trail except: [:client, :description, :title, :rfp, :new_client]

  validates :title, presence: true
  validates :client, presence: true


  def self.stages
    ["Prospect", "Proposal", "Won", "Lost"]
  end

  def self.stages_select_collection
    collection = Hash.new
    Project.stages.each { |stage| collection[stage] = stage }
    collection
  end

end
