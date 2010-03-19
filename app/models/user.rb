class User < ActiveRecord::Base
  acts_as_authentic do |config|
    # If nothing will be needed here, the block can be removed
  end
end
