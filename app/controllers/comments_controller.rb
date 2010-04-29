class ComentsController < ApplicationController

  before_filter :require_user

  def create
    comment_params = params[:comment] || {}
    comment_params[:user_id] = current_user.id
    comment_params[:error_id] = params[:id]
    @comment = Comment.create! comment_params

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml  => @comment, :status => :created }
      format.json { render :json => @comment, :status => :created }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml  => e.record.errors, :status => :unprocessable_entity }
      format.json { render :json => e.record.errors, :status => :unprocessable_entity }
    end
  end

end
