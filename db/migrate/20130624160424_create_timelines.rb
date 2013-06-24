class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :dump_file
      t.string :test_name

      t.timestamps
    end
  end
end
