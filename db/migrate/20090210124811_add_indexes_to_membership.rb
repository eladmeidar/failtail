class AddIndexesToMembership < ActiveRecord::Migration
  def self.up
    change_table :memberships do |t|
      t.index :project_id
      t.index :user_id
    end
  end

  def self.down
    change_table :memberships do |t|
      t.remove_index :project_id
      t.remove_index :user_id
    end
  end
end
