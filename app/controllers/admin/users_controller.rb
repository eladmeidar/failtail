class Admin::UsersController < ApplicationController

  helper_method :users, :user

  before_filter :require_user
  before_filter :require_admin

  def index
    users
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => users }
      format.json { render :json => users }
    end
  end

  def show
    redirect_to [:edit, :admin, user]
  end

  def new
    @user = User.new(params[:user])
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => user }
      format.json { render :json => user }
    end
  end

  def edit
    user
    respond_to do |format|
      format.html # render index.html.erb
      format.xml  { render :xml  => user }
      format.json { render :json => user }
    end
  end

  def create
    @user = User.create!(params[:user])
    respond_to do |format|
      format.html { redirect_to [:admin, user] }
      format.xml  { render :xml  => user, :status => :created }
      format.json { render :json => user, :status => :created }
    end
  rescue ActiveRecord::RecordInvalid => e
    @user = e.record
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end

  def update
    user.update_attributes! params[:user]
    respond_to do |format|
      format.html { redirect_to [:admin, user] }
      format.xml  { render :xml  => user }
      format.json { render :json => user }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :action => 'edit' }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path }
      format.xml  { render :noting, :status => :success }
      format.json { render :noting, :status => :success }
    end
  end

private

  def users
    @users ||= User.paginate :page => params[:page]
  end

  def user
    if params[:id].blank?
      @user
    else
      @user ||= User.find(params[:id])
    end
  end

end
