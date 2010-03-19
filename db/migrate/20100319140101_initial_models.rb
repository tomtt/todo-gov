class InitialModels < ActiveRecord::Migration
  def self.up
    create_table :lists, :force => true do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    create_table :items, :force => true do |t|
      t.references :list
      t.string :name
      t.timestamps
    end

    create_table :user_lists, :id => :false do |t|
      t.references :user
      t.references :list
      t.timestamps
    end
    add_index :user_lists, [:user_id, :list_id], :unique => true

    create_table :checked_items, :force => true do |t|
      t.references :user
      t.references :item
      t.timestamps
    end
  end

  def self.down
    remove_index :user_lists, :column => [:user_id, :list_id]
    drop_table :items
    drop_table :lists
    drop_table :user_lists
    drop_table :checked_items
  end
end
