class CreateErrors < ActiveRecord::Migration
  def self.up
    create_table :errors do |t|
      t.string :project_id
      t.string :hash_string
      t.string :name
      t.text :description
      t.text :properties
      t.text :backtrace
      t.boolean :closed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :errors
  end
end
