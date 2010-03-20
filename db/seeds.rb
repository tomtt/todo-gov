list = List.find_or_initialize_by_name("Register a Death")
if list.new_record? && Item.count == 0
  File.read("scratch.txt").split("\n").grep(/^\[\]/).each{|v| name = v.gsub('[] ', ''); Item.create!(:name => name, :list => list) }
end

def set_default_widgets_on_items(name, widgets)
  item = Item.find_by_name(name)
  return if !item || !item.widgets.empty?
  item.update_attributes(:widgets => widgets)
end

set_default_widgets_on_items("notify the family GP", %w{find_your_nearest_gp})
set_default_widgets_on_items("register the death at a register office",
                             %w{contact_the_register_office})
set_default_widgets_on_items("item with many widgets",
                             %w{find_your_nearest_gp contact_the_register_office})
