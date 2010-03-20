class AddWidgetsToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :widgets, :text
  end

  def self.down
    remove_column :items, :widgets
  end
end
