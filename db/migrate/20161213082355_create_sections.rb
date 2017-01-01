class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.references :department
      t.string :name

      t.timestamps
    end
  end
end
