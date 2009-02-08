class OccurencesController < ApplicationController

  helper_method :project, :error, :occurence
  
  before_filter :require_user
  before_filter :require_membership

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
  
  def require_membership
    unless current_user.member?(occurence)
      store_location
      flash[:notice] = "You must be a member of this project"
      redirect_to home_path
      return false
    end
  end

end
