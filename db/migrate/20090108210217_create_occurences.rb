class CreateOccurences < ActiveRecord::Migration
  def self.up
    create_table :occurences do |t|
      t.integer :error_id
      t.text :properties

      t.timestamps
    end
  end

  def self.down
    drop_table :occurences
  end
end
