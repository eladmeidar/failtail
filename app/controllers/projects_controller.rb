class ProjectsController < ApplicationController
  
  helper_method :projects, :project
  
  before_filter :require_user
  before_filter :require_membership, :only => :show
  before_filter :require_ownership, :only => [:edit, :update, :destroy]
  
  def index
    projects
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => projects }
      format.json { render :json => projects }
    end
  end
  
  def show
    project
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => project }
      format.json { render :json => project }
    end
  end
  
  def new
    @project = current_user.projects.build(params[:project])
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => project }
      format.json { render :json => project }
    end
  end
  
  def edit
    project
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => project }
      format.json { render :json => project }
    end
  end
  
  def create
    @project = current_user.projects.create!(params[:project])
    respond_to do |format|
      format.html { redirect_to project }
      format.xml  { render :xml  => project, :status => :created }
      format.json { render :json => project, :status => :created }
    end
  rescue ActiveRecord::RecordInvalid => e
    @project = e.record
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end
  
  def update
    project.update_attributes! params[:project]
    respond_to do |format|
      format.html { redirect_to project }
      format.xml  { render :xml  => project }
      format.json { render :json => project }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :action => 'edit' }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end
  
  def destroy
    project.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.xml  { render :noting, :status => :success }
      format.json { render :noting, :status => :success }
    end
  end
  
  private
  
  def projects
    @projects ||= current_user.projects.all
  end
  
  def project
    if params[:id].blank?
      @project
    else
      @project ||= current_user.projects.find(params[:id])
    end
  end
  
end