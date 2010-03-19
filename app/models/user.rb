class User < ActiveRecord::Base
  has_many :user_lists
  acts_as_authentic do |config|
    config.validate_email_field false
  end

  serialize :datamap
end
