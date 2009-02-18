class AddEnabledToServiceSetting < ActiveRecord::Migration
  def self.up
    change_table :service_settings do |t|
      t.boolean :enabled, :default => false
    end
  end

  def self.down
    change_table :service_settings do |t|
      t.remove :enabled
    end
  end
end
