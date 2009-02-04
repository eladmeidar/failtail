class SetOwnerships < ActiveRecord::Migration
  def self.up
    Membership.all.each do |membership|
      if membership.user_id == membership.project.owner_id
        membership.role = 'owner'
        membership.save!
      end
    end
  end

  def self.down
    Membership.all(:conditions => {:role => 'owner'}).each do |membership|
      project = membership.project
      project.owner = membership.user
      project.save!
    end
  end
end
