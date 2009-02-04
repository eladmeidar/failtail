class RemoveOwnerFromProject < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.remove :owner_id
    end
  end

  def self.down
    change_table :projects do |t|
      t.integer :owner_id
    end
  end
end
