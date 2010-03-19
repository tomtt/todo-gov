class DatamapForUser < ActiveRecord::Migration
  def self.up
    add_column :users, :datamap, :text
  end

  def self.down
    remove_column :users, :datamap
  end
end
