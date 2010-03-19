list = List.create!(:name => "Register a Death")
File.read("scratch.txt").split("\n").grep(/^\[\]/).each{|v| name = v.gsub('[] ', ''); Item.create!(:name => name, :list => list) }
