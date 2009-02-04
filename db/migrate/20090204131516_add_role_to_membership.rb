class AddRoleToMembership < ActiveRecord::Migration
  def self.up
    change_table :memberships do |t|
      t.string :role, :default => 'normal', :null => false
    end
  end

  def self.down
    change_table :memberships do |t|
      t.remove :role
    end
  end
end
