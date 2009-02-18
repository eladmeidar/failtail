class Report < ActivePresenter::Base
  
  presents :project, :error, :occurence
  
  before_validation :find_project
  before_validation :find_error
  
  before_validation :link_error_to_project
  before_validation :link_occurence_to_error
  
  after_save :deliver_notifications_to_services
  
  private
  
  def find_project
    pro = Project.find_by_api_token(@project.api_token)
    @project = pro if pro
  end
  
  def find_error
    err = @project.reports.find_by_hash_string(@error.hash_string)
    if err
      err.closed = false
      @error = err
    end
  end
  
  def link_error_to_project
    @error.project = @project
  end
  
  def link_occurence_to_error
    @occurence.error = @error
  end
  
  def deliver_notifications_to_services
    find_service_settings.each do |service_setting|
      next unless service_setting.enabled
      next if service_setting.new_errors_only and !@occurence.first?
      service_type = service_setting.service_type
      owner_type   = service_setting.service_owner.class.to_s.tableize.to_sym
      if Service::Base.enabled_services.include? service_type
        service_class = "services/#{service_type}_service".classify.constantize
        if service_class.locations.include? owner_type
          service_class.report(@occurence, service_setting)
        end
      end
    end
  end
  
  def find_service_settings
    service_settings = []
    service_settings.concat @project.service_settings.all
    @project.memberships.all.each do |membership|
      service_settings.concat membership.service_settings.all
    end
    service_settings
  end
  
end