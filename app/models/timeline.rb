class Timeline < ActiveRecord::Base
  attr_accessible :json_digest, :json_file_name, :test_details, :test_name, :device_name
end
