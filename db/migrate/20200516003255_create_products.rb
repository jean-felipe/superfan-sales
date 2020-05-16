class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :ean, null: false
      t.text :description, null: false
      t.integer :category_id, null: false
      t.references :company, null: false, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
