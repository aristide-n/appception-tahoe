class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :test_name
      t.text :test_details
      t.string :json_file_name
      t.text :json_digest

      t.timestamps
    end
  end
end
