class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
