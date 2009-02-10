class AddIndexesToOccurence < ActiveRecord::Migration
  def self.up
    change_table :occurences do |t|
      t.index :error_id
    end
  end

  def self.down
    change_table :occurences do |t|
      t.remove_index :error_id
    end
  end
end
