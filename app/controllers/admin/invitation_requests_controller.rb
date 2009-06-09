class Admin::InvitationRequestsController < ApplicationController
  
  helper_method :invitation_requests, :invitation_request
  
  before_filter :require_user
  before_filter :require_admin
  
  def index
    invitation_requests
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => invitation_requests }
      format.json { render :json => invitation_requests }
    end
  end
  
  def update
    invitation_request.create_invitation
    respond_to do |format|
      format.html { redirect_to admin_invitation_requests_path }
      format.xml  { render :xml  => invitation_request }
      format.json { render :json => invitation_request }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :action => 'edit' }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end
  
  def destroy
    invitation_request.destroy
    respond_to do |format|
      format.html { redirect_to admin_invitation_requests_path }
      format.xml  { render :noting, :status => :success }
      format.json { render :noting, :status => :success }
    end
  end
  
  private
  
  def invitation_requests
    @invitation_requests ||= InvitationRequest.paginate :page => params[:page]
  end
  
  def invitation_request
    if params[:id].blank?
      @invitation_request
    else
      @invitation_request ||= InvitationRequest.find(params[:id])
    end
  end
  
end
