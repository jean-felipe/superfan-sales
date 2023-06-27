class CreateServiceDefinitions < ActiveRecord::Migration[7.0]
  def change
    create_table :service_definitions do |t|
      t.references :company, null: false, foreign_key: true
      t.jsonb :definitions, default: {}
      t.integer :status, default: 0
      t.integer :service_type, default: 0
      t.string :code
      t.string :name

      t.float :price
      t.boolean :has_discount, default: false
      t.float :discount_price

      t.timestamps
    end
  end
end
