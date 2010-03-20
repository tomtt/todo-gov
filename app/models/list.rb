class List < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  validates_presence_of :name
end
