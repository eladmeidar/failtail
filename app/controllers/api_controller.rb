class ApiController < ApplicationController
  
  def status
    users_count      = User.count
    occurences_count = Occurence.count
    render :json => {
      :user_count       => users_count,
      :occurence_count  => occurences_count
    }
  end
  
end
