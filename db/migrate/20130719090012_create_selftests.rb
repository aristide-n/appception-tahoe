class CreateSelftests < ActiveRecord::Migration
  def change
    create_table :selftests do |t|
      t.string :name
      t.decimal :k_ops
      t.decimal :ms_time

      t.timestamps
    end
  end
end
