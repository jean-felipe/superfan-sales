class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :places, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
