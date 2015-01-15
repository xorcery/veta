require 'csv'

namespace :veta do
  desc "Deletes all projects and re-imports from csv"
  task :historic_pipeline_import => :environment do
    #Delete current projects
    Project.destroy_all

    #import new projects from a csv
    CSV.foreach("#{Rails.root}/data/historic_pipeline.csv") do |row|
      puts "Processing: #{row}"
      project = Project.new
      project.client = row[2].to_s.strip
      project.title = row[3].to_s.strip
      project.project_type = row[4].to_s.strip
      project.rfp = row[5].to_s.strip != "Negotiated"
      project.new_client = row[6].to_s.strip == "New"
      project.pipeline_owner = User.find_by(first_name: row[7].strip)
      consulting_revenue = row[9].to_s.gsub(",","").gsub("$","").gsub("-","").strip
      project.consulting_revenue = consulting_revenue.to_f if consulting_revenue.length > 0
      other_revenue = row[10].to_s.gsub(",","").gsub("$","").gsub("-","").strip
      project.other_revenue = other_revenue.to_f if other_revenue.length > 0
      project.stage = row[11].to_s.strip

      identified = row[12].to_s.strip.gsub("201","1")
      project.identified_on = DateTime.strptime(identified, "%m/%d/%y") if identified.length > 0

      submitted = row[13].to_s.strip.gsub("201","1")
      project.submitted_on = DateTime.strptime(submitted, "%m/%d/%y") if submitted.length > 0

      authorized = row[14].to_s.strip.gsub("201","1")
      project.authorized_on = DateTime.strptime(authorized, "%m/%d/%y") if authorized.length > 0


      lost = row[15].to_s.strip.gsub("201","1")
      project.lost_on = DateTime.strptime(lost, "%m/%d/%y") if lost.length > 0

      project.comments = row[16].to_s.strip

      project.probability = row[18].to_s.strip.gsub("%","").to_f / 100.0
      project.start_on = DateTime.strptime(row[19].to_s.strip, "%b-%y")
      project.months = row[20].to_s.strip.to_i

      project.save!
    end

  end
end