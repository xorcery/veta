module PipelineHelper
  def display_date(rec)
    if rec.present?  
      rec.strftime('%m/%d/%Y')
    else
      '-'
    end  
  end  
end
