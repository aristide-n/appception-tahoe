class RenameOrderColumnOfTimeline < ActiveRecord::Migration
  def change
    rename_column :timelines, :order, :chart_order
  end
end
