class Environment < ActiveRecord::Base
  attr_accessible :device_name, :platform, :user_agent
  has_many :selftests
  before_destroy :destroy_selftests

  def destroy_selftests
    self.selftests.each do |selftest|
      selftest.destroy
    end
  end

end
