class Selftest < ActiveRecord::Base
  attr_accessible :k_ops, :ms_time, :name, :environment_id
  belongs_to :environment

end
