class AddStatsType < ActiveRecord::Migration[5.0]
  def change
    add_column :statistics, :data_type, :integer, default: 0, null: false
  end
end
