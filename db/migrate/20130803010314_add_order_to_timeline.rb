class AddOrderToTimeline < ActiveRecord::Migration
  def change
      add_column :timelines, :order, :integer
  end
end
