class Report
  
  def self.create!(params)
    project = Project.first(:conditions => params.only(:api_token))
    error = project.reports.first(:conditions => params[:error].only(:hash_string))
    
  end
  
end