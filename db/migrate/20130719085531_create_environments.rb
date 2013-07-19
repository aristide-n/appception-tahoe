class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :user_agent
      t.string :platform
      t.string :device_name

      t.timestamps
    end
  end
end
