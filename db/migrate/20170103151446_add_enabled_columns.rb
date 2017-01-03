class AddEnabledColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :departments, :enabled, :boolean, default: true, null: false
    add_column :sections, :enabled, :boolean, default: true, null: false
  end
end
