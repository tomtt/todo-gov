class CheckedItemsShouldBelongToUserList < ActiveRecord::Migration
  def self.up
    remove_column :checked_items, :user_id
    add_column :checked_items, :user_list_id, :integer
  end

  def self.down
    remove_column :checked_items, :user_list_id
    add_column :checked_items, :user_id, :integer
  end
end
