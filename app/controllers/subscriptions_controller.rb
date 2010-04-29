class SubscriptionsController < ApplicationController

  def create
    if params[:subscription] and email = params[:subscription][:email]
      subscriber = Campaigning::Subscriber.new(email, nil)
      subscriber.add_and_resubscribe!(CAMPAIGN_MONITOR_LIST_ID) rescue nil
      flash[:notice] = 'Thank you for subscribing to our newsletter.'
      redirect_to :back
    else
      flash[:notice] = 'You didn\'t provide a valid email address.'
      redirect_to :back
    end
  end

end