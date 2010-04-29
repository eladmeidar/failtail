class ServiceSettingsController < ApplicationController

  before_filter :require_user
  before_filter :require_ownership, :only => [:destroy, :update, :create]

  def create
    service_setting.save!

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml  => service_setting, :status => :created }
      format.json { render :json => service_setting, :status => :created }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end

  def update
    service_setting.update_attributes!(params[:service_setting])

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml  => service_setting, :status => :created }
      format.json { render :json => service_setting, :status => :created }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    service_setting.destroy
    redirect_to project
  end

  private

  def service_setting
    if params[:id]
      @service_setting ||= ServiceSetting.find(params[:id])
    else
      params[:service_setting][:properties] ||= { :_dummy => :string }
      @service_setting ||= ServiceSetting.new(params[:service_setting])
    end
  end

  def require_ownership
    unless current_user.owner?(service_setting.service_owner)
      store_location
      flash[:notice] = "You have insufficient privileges to do that."
      redirect_to home_path
      return false
    end
  end
end
