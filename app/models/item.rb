class Item < ActiveRecord::Base
  belongs_to :list
  validates_presence_of :list
end
