class CreateErrors < ActiveRecord::Migration
  def self.up
    create_table :errors do |t|
      t.integer :project_id
      t.string :hash_string
      t.boolean :closed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :errors
  end
end
