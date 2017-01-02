class AddProductColumnToStatistic < ActiveRecord::Migration[5.0]
  def change
    add_column :statistics, :product_id, :integer
  end
end
