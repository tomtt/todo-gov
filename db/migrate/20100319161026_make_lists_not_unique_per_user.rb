class MakeListsNotUniquePerUser < ActiveRecord::Migration
  def self.up
    remove_index :user_lists, :column => [:user_id, :list_id]
  end

  def self.down
  end
end
