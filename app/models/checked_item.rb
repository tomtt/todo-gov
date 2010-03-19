class CheckedItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :user_list
  validates_presence_of :item, :user_list
end
