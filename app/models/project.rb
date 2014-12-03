class Project < ActiveRecord::Base

  has_paper_trail except: [:client, :title, :rfp, :new_client, 
                           :project_type, :code, :comments]

  validates :title, presence: true
  validates :client, presence: true
  validates :other_revenue, numericality: true, allow_nil: true
  validates :consulting_revenue, numericality: true, allow_nil: true
  validates :gross_contract, numericality: true, allow_nil: true

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
