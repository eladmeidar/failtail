class Occurence < ActiveRecord::Base

  def self.per_page ; 20 ; end

  validates_presence_of :error
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :properties
  validates_presence_of :reporter

  validate do |occurrence|
    msg = "properties must be a hash with strings for keys and values."
    props = occurrence.properties
    if props
      if Hash === props
        props.each do |k,v|
          unless String === k and String === v
            occurrence.errors.add(:properties, msg)
            break
          end
        end
      else
        occurrence.errors.add(:properties, msg)
      end
    end
  end

  validate do |occurrence|
    if project = occurrence.error.try(:project)
      if project.occurences.count(:conditions => ["occurences.created_at >= ?", 60.minutes.ago]) > 900
        occurrence.errors.add(:name, "To many api call in the last 60 minutes")
      end
    end
  end

  serialize(:properties)

  belongs_to :error,
    :counter_cache => true,
    :class_name    => '::Error'
  has_one :project,
    :through       => :error
  has_many :comments,
    :through       => :error,
    :order         => 'comments.created_at ASC'

  default_scope :order => 'occurences.updated_at DESC'

  after_create :touch_parents

  def touch_parents
    self.error.update_attributes(:updated_at => DateTime.now)
    self.error.project.update_attributes(:updated_at => DateTime.now)
  end

  def first?
    self.error.occurences.count == 1
  end

end
