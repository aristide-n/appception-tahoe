class AddDeviceNameToTimeline < ActiveRecord::Migration
  def change
    add_column :timelines, :device_name, :string
  end
end
