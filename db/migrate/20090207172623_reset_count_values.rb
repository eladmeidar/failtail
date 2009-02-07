class ResetCountValues < ActiveRecord::Migration
  def self.up
    Project.all do |project|
      Project.update_counters project.id, :errors_count => project.reports.all.size
    end
    Error.all do |error|
      Error.update_counters error.id, :occurences_count => error.occurences.all.size
    end
  end

  def self.down
  end
end
