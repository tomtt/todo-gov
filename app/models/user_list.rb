class CheckableItem
  attr_reader :item, :checked_item, :user

  def initialize(item, checked_item = nil, user_list = nil)
    @item, @checked_item, @user_list = item, checked_item, user_list
  end

  def checked?
    !@checked_item.nil?
  end

  def check!
    if not checked?
      @checked_item = CheckedItem.create!(:item => @item, :user_list => @user_list)
    end
  end

  def uncheck!
    if checked?
      @checked_item.destroy
      @checked_item = nil
    end
  end

  def checked=(v)
    v ? check! : uncheck!
  end

  delegate :name, :id, :desription, :to => :item
end

class UserList < ActiveRecord::Base
  belongs_to :list
  belongs_to :user
  has_many :checked_items
  validates_presence_of :user, :list

  def items
    @items ||= (
      checked_items_map = checked_items.inject({}){|acc, checked_item| acc.merge(checked_item.item_id => checked_item) }
      list.items.map{|item| CheckableItem.new(item, checked_items_map[item.id], self)}
    )
  end

  def item(id)
    items.find{|item| item.id == id.to_i }
  end

  def completed_percentage
    (items.select(&:checked?).size * 100 ) / items.size
  end

  validates_presence_of :list
  delegate :name, :to => :list

  def to_s
    name
  end
end
