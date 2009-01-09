class ProjectsController < ApplicationController
  
  helper_method :projects, :project
  
  before_filter :require_user
  before_filter :require_membership, :only => :show
  before_filter :require_ownership, :only => [:edit, :update, :destroy]
  
  def index
    projects
  end
  
  def show
    project
  end
  
  def new
    project
  end
  
  def edit
    project
  end
  
  def create
    project.save!
    redirect_to project
  rescue ActiveRecord::RecordInvalid => e
    render :action => 'new'
  end
  
  def update
    project.update_attributes! params[:project]
    redirect_to project
  rescue ActiveRecord::RecordInvalid => e
    render :action => 'edit'
  end
  
  def destroy
    project.destroy
    redirect_to root_path
  end
  
  private
  
  def projects
    @projects ||= current_user.projects.all
  end
  
  def project
    if params[:id].blank?
      @project ||= current_user.owned_projects.build(params[:project])
    else
      @project ||= current_user.projects.find(params[:id])
    end
  end
  
end