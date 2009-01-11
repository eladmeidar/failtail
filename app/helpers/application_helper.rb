# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def render_shared(template,options={})
    options[:partial] = "/shared/#{template}"
    render options
  end
  
end
