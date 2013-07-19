class Environment < ActiveRecord::Base
  attr_accessible :device_name, :platform, :user_agent
  has_many :selftests

end
