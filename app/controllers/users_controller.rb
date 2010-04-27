class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :only_if_registration_allowed, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    term  = params[:term]
    @users = User.find_by_sql("SELECT name, email FROM users WHERE email LIKE '%#{term}%'")
    if request.xhr?
      render :json => { :users => @users }
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @invitation.destroy unless @invitation.nil?
      flash[:notice] = "Account registered!"
      redirect_back_or_default root_url
    else
      render :action => :new
    end
  end
  
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to root_url
    else
      render :action => :edit
    end
  end
  
  
  
  private
  
  def only_if_registration_allowed
    unless FAILTALE[:allow_registration]
      if FAILTALE[:allow_invitations] and !params[:invitation].blank?
        @invitation = Invitation.first(:conditions => {:code => params[:invitation]})
        unless @invitation
          redirect_to root_path
          return false
        end
      else
        redirect_to root_path
        return false
      end
    end
  end
  
end
