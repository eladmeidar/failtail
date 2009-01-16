class CreateOccurences < ActiveRecord::Migration
  def self.up
    create_table :occurences do |t|
      t.integer :error_id
      t.string :name
      t.text :description
      t.text :backtrace
      t.text :properties

      t.timestamps
    end
  end

  def self.down
    drop_table :occurences
  end
end
