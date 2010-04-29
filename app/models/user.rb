class User < ActiveRecord::Base
  acts_as_authentic

  validates_presence_of :name
  validates_presence_of :login
  validates_presence_of :email

  validates_length_of :name, :minimum => 2
  validates_length_of :login, :minimum => 2

  validates_uniqueness_of :login
  validates_uniqueness_of :email

  has_many :memberships,
    :dependent  => :destroy
  has_many :projects,
    :through    => :memberships
  has_many :owned_projects,
    :through    => :memberships,
    :source     => :project,
    :conditions => { 'memberships.role' => 'owner' }
  has_many :comments,
    :dependent  => :destroy,
    :order      => 'comments.created_at ASC'

  after_save :manage_newsletter_subscription

  default_scope :order => 'name ASC'

  def owner?(record, aggregate=false)
    case record
    when Membership
      if aggregate
        record.role == 'owner' and record.user_id == self.id
      else
        record.user_id == self.id
      end
    when Project    then owner?(memberships.first(:conditions => {:project_id => record.id}), true)
    when ::Error    then owner?(record.project, true)
    when Occurence  then owner?(record.error, true)
    else false
    end
  end

  def member?(record)
    case record
    when Membership then record.user_id == self.id
    when Project    then member?(memberships.first(:conditions => { :project_id => record.id }))
    when ::Error    then member?(record.project)
    when Occurence  then member?(record.error)
    else false
    end
  end

  def gravatar_url(options={})
    return nil unless self.email
    @gravatar_url ||= Gravatar.url_for(self.email, options)
  end

  def can_create_one_more_project?
    self.admin or self.owned_projects.size < 3
  end

private

  def manage_newsletter_subscription
    if self.new_record? or self.newsletter_changed?
      if self.newsletter
        subscribe_to_newsletter
      else
        unsubscribe_from_newsletter
      end
    end
  end

  def subscribe_to_newsletter
    subscriber = Campaigning::Subscriber.new(self.email, self.name)
    subscriber.add_and_resubscribe!(CAMPAIGN_MONITOR_LIST_ID)
    true
  end

  def unsubscribe_from_newsletter
    subscriber = Campaigning::Subscriber.new(self.email)
    subscriber.unsubscribe!(CAMPAIGN_MONITOR_LIST_ID)
    true
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
