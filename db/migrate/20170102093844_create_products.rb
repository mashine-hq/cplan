class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
  end
end
