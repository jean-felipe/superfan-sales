class CreateSaleItems < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_items do |t|
      t.references :sale, null: false, foreign_key: true
      t.integer :product_id, null:false
      t.float :quantity, null:false
      t.integer :quantity_unit, null:false, default: 0
      t.float :price, null:false

      t.timestamps
    end
  end
end
