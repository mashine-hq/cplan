class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :units
      t.date :report_at
      t.integer :summary
      t.references :statistic, foreign_key: true

      t.timestamps
    end
  end
end
