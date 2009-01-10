class Report
  
  class Invalid < Exception
    def intialize(base)
      @report = base
    end
  end
  
  def self.create!(params={})
    new(params).save!
  end
  
  attr_accessor :project, :error, :occurence
  
  def initialize(params={})
    self.project   = params['project']
    self.error     = params['error']
    self.occurence = params['occurence']
  end
  
  def valid?
    (!occurence.nil? and !project.nil?  and !error.nil? and
    occurence.valid? and project.valid? and error.valid?)
  end
  
  def save!
    raise Report::Invalid.new(self) unless valid?
    @error.save!
    @occurence.save!
  end
  
  def project=(object)
    if object.is_a? Hash
      @project = Project.with_api_token(object['api_token']).first
    elsif object.is_a? Project
      @project = object
    else
      @project = nil
    end
  end
  
  def error=(object)
    if @project.nil?
      @error = nil
    elsif object.is_a? Hash
      @error   = @project.reports.with_hash(object['hash_string']).first
      @error ||= @project.reports.build(object)
      if @error.new_record?
        @error.save!
        @error_was_created = true
      end
    elsif object.is_a? Error
      @error = object
    else
      @error = nil
    end
  end
  
  def occurence=(object)
    if @error.nil?
      @occurence = nil
    elsif object.is_a? Hash
      @occurence = @error.occurences.build(object)
    elsif object.is_a? Occurence
      @occurence = object
    else
      @occurence = nil
    end
  end
  
end