# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def sidebar_message_block
    mb = message_block.strip
    unless mb == '<div id="message_block"></div>'
      "<div class=\"block\"><h3></h3>#{mb}</div>"
    end
  end
  
  def render_shared(template,options={})
    options[:partial] = "/shared/#{template}"
    render options
  end
  
  class MenuBlockBuilder
    def initialize(template)
      @template = template
      @links = []
    end
    
    def build(&block)
      block.call(self)
      l = @links.size - 1
      @links.each_with_index do |(link, active), i|
        classes = []
        classes << 'active' if active
        classes << 'first'  if i == 0
        classes << 'last'   if i == l
        classes = classes.join(' ')
        @template.send(:concat, %{<li class="#{classes}">#{link}</li>})
      end
    end
    
    def to(name, url, *args, &conditions)
      url = @template.send(:url_for, url)
      conditions ||= lambda { @template.send(:request).path == url }
      link = @template.send(:link_to, name, url, *args)
      @links << [link, conditions.call]
    end
  end
  
  def menu_block(options={}, &block)
    concat(tag("ul", options, true))
    MenuBlockBuilder.new(self).build(&block)
    concat(%{ </ul> })
  end
  
  def actions(&block)
    content_for :sidebar_actions do
      concat('<div class="block"><h3>Actions</h3>')
      menu_block(:class => 'navigation', &block)
      concat('</div>')
    end
  end
  
  def list(colection, options={}, item_options={})
    concat(tag("ul", options, true))
    l = colection.size - 1
    colection.each_with_index do |item, i|
      
      classes = [(item_options[:class] || '').split(' ')].flatten.compact
      classes << 'first'  if i == 0
      classes << 'last'   if i == l
      item_options[:class] = classes.join(' ')
      
      concat(tag("li", item_options, true))
      yield(item)
      concat('</li>')
    end
    concat('</ul>')
  end
  
end
