class InvitationRequestsController < ApplicationController

  before_filter :only_if_invitations_allowed

  def new
    @invitation = InvitationRequest.new
  end

  def create
    @invitation = InvitationRequest.new(params[:invitation_request])
    if @invitation.save
      flash[:notice] = "Invitation send!"
      redirect_to root_url
    else
      render :action => :new
    end
  end

  private

  def only_if_invitations_allowed
    unless FAILTALE[:allow_invitations]
      redirect_to root_path
      return false
    end
  end

end