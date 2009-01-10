class ReportsController < ApplicationController
  
  def create
    report.save!
    response = { :success => 1 }
    status   = :created
  rescue Report::Invalid => e
    response = { :success => 0 }
    status   = :unprocessable_entity
  ensure
    respond_to do |format|
      format.json { render :json => response, :status => status }
      format.xml  { render :xml  => response, :status => status }
    end
  end
  
  private
  
  def report
    @report ||= Report.new(params[:report])
  end
  
end
