class AddCounterCaches < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.integer :errors_count, :default => 0
    end
    change_table :errors do |t|
      t.integer :occurences_count, :default => 0
    end
  end

  def self.down
    change_table :projects do |t|
      t.remove :errors_count
    end
    change_table :errors do |t|
      t.remove :occurences_count
    end
  end
end
