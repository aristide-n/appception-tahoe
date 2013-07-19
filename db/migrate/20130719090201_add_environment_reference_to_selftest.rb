class AddEnvironmentReferenceToSelftest < ActiveRecord::Migration
  def change
    change_table :selftests do |t|
      t.references :environment
    end
  end
end
