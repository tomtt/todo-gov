class User < ActiveRecord::Base
  before_save :ensure_datamap_is_a_hash
  has_many :user_lists
  acts_as_authentic do |config|
    config.validate_email_field false
  end

  serialize :datamap

  private

  def ensure_datamap_is_a_hash
    self.datamap ||= {}
  end
end
