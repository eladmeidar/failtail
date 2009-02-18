class CreateServiceSettings < ActiveRecord::Migration
  def self.up
    create_table :service_settings do |t|
      t.integer :service_owner_id
      t.string :service_owner_type
      t.string :service_type
      t.boolean :new_errors_only, :default => false
      t.text :properties

      t.timestamps
    end
    add_index :service_settings, :service_owner_id
    add_index :service_settings, :service_owner_type
  end

  def self.down
    remove_index :service_settings, :service_owner_id
    remove_index :service_settings, :service_owner_type
    drop_table :service_settings
  end
end
