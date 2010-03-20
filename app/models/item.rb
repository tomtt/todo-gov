class Item < ActiveRecord::Base
  belongs_to :list
  validates_presence_of :list

  before_save :ensure_widgets_is_an_array

  serialize :widgets

  private

  def ensure_widgets_is_an_array
    self.widgets ||= []
  end
end
