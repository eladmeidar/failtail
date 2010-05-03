class MembershipsController < ApplicationController

  before_filter :require_user
  before_filter :require_project_ownership, :only => [:new, :create]
  before_filter :require_ownership, :only => [:destroy]

  def new
    @membership = project.memberships.build
  end

  def edit
    allowed_services = Service::Base.enabled_services.dup
    @service_settings = membership.service_settings.all

    @service_settings = @service_settings.collect do |service_setting|
      type_name = service_setting.service_type
      if allowed_services.include? type_name
        allowed_services.delete(type_name)
        service_setting
      else
        service_setting.destroy
      end
    end.compact

    allowed_services.each do |type_name|
      @service_settings.push(ServiceSetting.new(
        :service_owner => membership,
        :service_type  => type_name,
        :properties    => {}
      ))
    end
  end

  def create
    @membership = project.memberships.build(params[:membership])
    @membership.save!

    respond_to do |format|
      format.html { redirect_to project }
      format.xml  { render :xml  => @membership, :status => :created }
      format.json { render :json => @membership, :status => :created }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    membership.destroy
    redirect_to membership.project
  end

private

  def project
    @project ||= current_user.projects.find(params[:project_id])
  end

  def membership
    @membership ||= Membership.find(params[:id])
  end

  def require_project_ownership
    unless current_user.owner?(project)
      store_location
      flash[:notice] = "You must be the owner of this project"
      if current_user.member?(project)
        redirect_to project
      else
        redirect_to project_path()
      end
      return false
    end
  end

  def require_ownership
    unless current_user.owner?(membership) or current_user.owner?(membership.project)
      store_location
      flash[:notice] = "You must be the owner of this project"
      redirect_to membership.project
      return false
    end
  end

end
