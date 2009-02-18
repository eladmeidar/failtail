class Reporter
  
  attr_reader :name, :template_path
  
  def self.all(force=false)
    return @reporters if @reporters and !force
    @reporters = {}
    Dir.glob(File.join(Rails.root, 'app/views/reporters/*.html.*')).each do |path|
      reporter = new(File.basename(path).split('.').first, path)
      @reporters[reporter.name] = reporter
    end
    @reporters
  end
  
  def self.find(name)
    self.all[name]
  end
  
  def initialize(name, template_path)
    @name, @template_path = name, template_path
  end
  
end