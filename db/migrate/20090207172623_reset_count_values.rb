class ResetCountValues < ActiveRecord::Migration
  def self.up
    Project.all do |project|
      project.errors_count = project.reports.count
      project.save!
    end
    Error.all do |error|
      error.occurences_count = error.occurences.count
      error.save!
    end
  end

  def self.down
  end
end
