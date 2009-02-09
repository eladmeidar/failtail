require 'digest/md5'
require 'uri'

module Gravatar
  # http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?s=80
  
  GATEWAY  = "http://www.gravatar.com/avatar/"
  RATINGS  = [:g, :pg, :r, :x]
  SIZES    = 1..512
  DEFAULTS = [:identicon, :monsterid, :wavatar]
  URI_REGEXP = Regexp.new("^#{URI.regexp(['http', 'https'])}$")
  
  def self.url_for(email, options={})
    options = options.to_options.slice(:rating, :default, :size)
    
    unless email.is_a? String
      raise ArgumentError, "email must be a String"
    end
    
    unless options[:rating].nil? or RATINGS.include? options[:rating].to_sym
      raise ArgumentError, ":rating must be one of #{RATINGS.inspect}"
    end
    
    unless options[:size].nil? or SIZES.include? options[:size].to_i
      raise ArgumentError, ":size must be in #{SIZES.inspect}"
    end
    
    unless options[:default].nil? or
           DEFAULTS.include? options[:default].to_sym or
           options[:default].to_s =~ URI_REGEXP
      raise ArgumentError, ":default must be one of #{DEFAULTS.inspect} or a valid URL"
    end
    
    email = Digest::MD5.hexdigest(email.downcase)
    
    ["#{GATEWAY}#{email}.jpg", options.to_query].join('?')
  end
  
  module Helper
    def gravatar_url(email, options={})
      Gravatar.url_for(email, options)
    end
  end
end
