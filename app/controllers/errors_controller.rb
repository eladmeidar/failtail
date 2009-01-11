class ErrorsController < ApplicationController
  
  helper_method :error, :project
  
  before_filter :require_user
  before_filter :require_membership
  
  def show
    error
  end
  
  private
  
  def project
    @project ||= current_user.projects.find(params[:project_id])
  end
  
  def error
    @error ||= project.reports.find(params[:id])
  end
  
end
