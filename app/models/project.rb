class Project < ActiveRecord::Base

  has_paper_trail except: [:client, :title, :rfp, :new_client, 
                           :project_type, :code, :comments]

  validates :title, presence: true
  validates :client, presence: true
  validates :other_revenue, numericality: true, allow_nil: true
  validates :consulting_revenue, numericality: true, allow_nil: true
  validates :gross_contract, numericality: true, if: Proc.new { |a| a.stage == 'Won' }

  belongs_to :pipeline_owner, class_name: "User"
  belongs_to :backlog_owner, class_name: "User"

  before_validation :infer_backlog_values

  def self.pipeline
    Project.all.order(:client, :title)
  end

  def self.backlog
    Project.all.order(:client, :title)
  end

  ##SELECT collection helpers

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

  def infer_backlog_values
    if self.consulting_revenue.present? or self.other_revenue.present?
      self.gross_contract ||= self.consulting_revenue.to_f + (self.other_revenue.to_f * self.months.to_i)
    end
    self.backlog_owner_id ||= self.pipeline_owner_id
  end


end
