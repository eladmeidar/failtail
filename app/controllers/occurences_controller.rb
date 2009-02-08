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
    @project ||= error.project
  end

  def error
    @error ||= occurence.error
  end

  def occurence
    @occurence ||= Occurence.find(params[:id])
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
