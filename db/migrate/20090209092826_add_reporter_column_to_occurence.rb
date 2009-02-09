class AddReporterColumnToOccurence < ActiveRecord::Migration
  def self.up
    change_table :occurences do |t|
      t.string :reporter, :default => ''
    end
  end

  def self.down
    change_table :occurences do |t|
      t.remove :reporter
    end
  end
end
