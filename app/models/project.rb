class Project < ActiveRecord::Base
  include AASM

  has_paper_trail except: [:client, :description, :title, :rfp, :new_client]

  aasm :column => 'current_state' do
    
  end

end
