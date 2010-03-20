class AddNotesToEachListItem < ActiveRecord::Migration
  def self.up
    add_column :checked_items, :checked, :boolean, :default => true, :null => false
    add_column :checked_items, :notes, :text
  end

  def self.down
    remove_column :checked_items, :notes
    remove_column :checked_items, :checked
  end
end
