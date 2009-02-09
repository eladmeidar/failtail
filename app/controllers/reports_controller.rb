class ReportsController < ApplicationController
  
  protect_from_forgery :only => []
  
  def create
    report.save!
    response = { :success => 1 }
    status   = :created
  rescue ActiveRecord::RecordInvalid => e
    response = { :success => 0, :errors => e.record.errors }
    status   = :unprocessable_entity
  ensure
    unless response.nil?
      respond_to do |format|
        format.json { render :json => response, :status => status }
        format.xml  { render :xml  => response, :status => status }
      end
    end
  end
  
  private
  
  def report
    @report ||= Report.new(params[:report])
  end
  
end
