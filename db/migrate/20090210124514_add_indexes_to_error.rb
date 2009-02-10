class AddIndexesToError < ActiveRecord::Migration
  def self.up
    change_table :errors do |t|
      t.index :project_id
      t.index :closed
    end
  end

  def self.down
    change_table :errors do |t|
      t.remove_index :project_id
      t.remove_index :closed
    end
  end
end
