class UserList < ActiveRecord::Base
  belongs_to :list
  delegate :name, :items, :to => :list
end
