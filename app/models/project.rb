class Project < ActiveRecord::Base
  #include AASM

  has_paper_trail except: [:client, :description, :title, :rfp, :new_client]

  validates :title, presence: true
  validates :client, presence: true

  #aasm :column => 'current_state' do
    
  #end

end
