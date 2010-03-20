list = List.find_or_initialize_by_name("Register a Death")
if list.new_record? && Item.count == 0
  File.read("scratch.txt").split("\n").grep(/^\[\]/).each{|v| name = v.gsub('[] ', ''); Item.create!(:name => name, :list => list) }
end
Item.find_by_name("notify the family GP").update_attributes(:widgets => %w{find_your_nearest_gp})
Item.find_by_name("register the death at a register office").update_attributes(:widgets => %w{contact_the_register_office})
Item.find_by_name("item with many widgets").update_attributes(:widgets => %w{find_your_nearest_gp contact_the_register_office})
