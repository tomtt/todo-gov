class CheckableItem
  attr_reader :item, :user

  def initialize(item, checked_item = nil, user_list = nil)
    @item, @checked_item, @user_list = item, checked_item, user_list
  end

  def checked?
    @checked_item and @checked_item.checked?
  end

  def check!
    if @checked_item and not checked?
      @checked_item.update_attribute(:checked, true) if not checked?
    elsif not checked?
      @checked_item = CheckedItem.create!(:item => @item, :user_list => @user_list, :checked => true)
    end
  end

  def uncheck!
    @checked_item.update_attribute(:checked, false) if checked?
  end

  def checked=(v)
    v ? check! : uncheck!
  end

  def notes=(v)
    checked_item.update_attribute(:notes, v)
  end

  def checked_item
    @checked_item ||= CheckedItem.create!(:item => @item, :user_list => @user_list, :checked => false)
  end

  delegate :notes, :to => :checked_item
  delegate :name, :id, :description, :to => :item
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
