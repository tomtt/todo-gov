class UserList < ActiveRecord::Base
  belongs_to :list
  validates_presence_of :list
  delegate :name, :items, :to => :list
end
