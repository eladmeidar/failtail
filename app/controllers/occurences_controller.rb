class OccurencesController < ApplicationController
  
  before_filter :require_user
  before_filter :require_project_membership

  helper_method :project, :error, :occurence

  def show
    occurence
  end

  def backtrace
    occurence
  end

  def environment
    occurence
  end

  private

  def project
    @project ||= current_user.projects.find(params[:project_id])
  end

  def error
    @error ||= project.reports.find(params[:error_id])
  end

  def occurence
    @occurence ||= error.occurences.find(params[:id])
  end

  def membership?
    !project.nil?
  end
  
  def require_project_membership
    unless membership?
      store_location
      flash[:notice] = "You must be a member of this project"
      redirect_to home_path
      return false
    end
  end

end
