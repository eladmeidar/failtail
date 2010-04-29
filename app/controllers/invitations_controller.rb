class InvitationsController < ApplicationController

  before_filter :require_user
  before_filter :only_if_invitations_allowed

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
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
