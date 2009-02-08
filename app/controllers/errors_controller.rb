class ErrorsController < ApplicationController
  
  helper_method :errors, :error, :project
  
  before_filter :require_user
  before_filter :require_membership, :except => [:index]
  
  def index
    errors
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => errors }
      format.json { render :json => errors }
    end
  end
  
  def show
    error
    respond_to do |format|
      format.html # render show.html.erb
      format.xml  { render :xml  => error }
      format.json { render :json => error }
    end
  end
  
  private
  
  def errors
    @errors ||= Error.all(:conditions => {:project_id => current_user.project_ids})
  end
  
  def error
    @error ||= Error.find(params[:id])
  end
  
  def require_membership
    unless current_user.member?(error)
      store_location
      flash[:notice] = "You must be a member of this project"
      redirect_to home_path
      return false
    end
  end
  
end
