class CreateCommentsTable < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :error_id
      t.integer :user_id
      t.text    :body
      t.timestamps
    end
    add_index :comments, :error_id
    add_index :comments, :user_id
    add_index :comments, :created_at
  end

  def self.down
    drop_table :comments
    remove_index :comments, :error_id
    remove_index :comments, :user_id
    remove_index :comments, :created_at
  end
end
