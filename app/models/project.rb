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

  def self.probability_select_collection
    collection = Hash.new
    (0..100).step(5) do |p|
      collection[p / 100.0] = "#{p}%"
    end
    collection
  end


  def self.months_select_collection
    collection = Hash.new
    (1..24).each {|month| collection[month] = month }
    collection
  end

end
