class Report < ActivePresenter::Base
  
  presents :project, :error, :occurence
  
  before_validation :find_project
  before_validation :find_error
  
  before_validation :link_error_to_project
  before_validation :link_occurence_to_error
  
  private
  
  def find_project
    pro = Project.find_by_api_token(@project.api_token)
    @project = pro if pro
  end
  
  def find_error
    if err = @project.reports.find_by_hash_string(@error.hash_string)
      @error = err
    end
  end
  
  def link_error_to_project
    @error.project = @project
  end
  
  def link_occurence_to_error
    @occurence.error = @error
  end
  
end