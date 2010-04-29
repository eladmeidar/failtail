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

  def render_reporter(occurence)
    reporter = Reporter.find(occurence.reporter)
    return '' if reporter.nil?
    render :file => reporter.template_path, :locals => {
      :occurence  => occurence,
      :properties => occurence.properties }
  end

  class MenuBlockBuilder
    def initialize(template, split=false)
      @template = template
      @split = split
      @links = []
      @content = ""
    end

    def build(&block)
      if @split
        @content = @template.send(:capture, self, &block)
      else
        block.call(self)
      end
      l = @links.size - 1
      @links.each_with_index do |(link, active), i|
        classes = []
        classes << 'active' if active
        classes << 'first'  if i == 0
        classes << 'last'   if i == l
        classes = classes.join(' ')
        @template.send(:concat, %{<li class="#{classes}">#{link}</li>})
      end
      @content
    end

    def to(name, url, *args, &conditions)
      url = @template.send(:url_for, url)
      conditions ||= lambda { @template.send(:request).path == url }
      link = @template.send(:link_to, name, url, *args)
      @links << [link, conditions.call]
    end
  end

  def menu_block(options={}, &block)
    split = options.delete(:split) || false
    concat(tag("ul", options, true))
    content = MenuBlockBuilder.new(self, split).build(&block)
    concat(%{ </ul> })
    content
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

  def block(title=nil, &block)
    concat(%{<div class="block"><div class="secondary-navigation">})
    content = menu_block(:split => true, &block) if block.arity == 1
    concat(%{<div class="clear"></div></div>})
    concat(%{<h2 class="title">#{h(title)}</h2>}) if title
    concat(%{<div class="content">})
    if block.arity == 1
      concat(content)
    else
      block.call
    end
    concat(%{</div></div>})
  end

  def block2(title=nil, &block)
    concat(%{<div class="block">})
    concat(%{<h2 class="title">#{h(title)}</h2>}) if title
    concat(%{<div class="content">})
    if block.arity == 1
      concat(content)
    else
      block.call
    end
    concat(%{</div></div>})
  end

  def css_class_first(value=nil, check=nil)
    unless value.nil? or check.nil?
      if value == check
        %{first}
      end
    end
  end

  def css_class_last(value=nil, check=nil)
    unless value.nil? or check.nil?
      if value == check
        %{last}
      end
    end
  end

  def css_class(class_name='', value=nil, check=nil)
    unless value.nil? or check.nil?
      if value == check
        %{#{class_name}}
      end
    end
  end

end
