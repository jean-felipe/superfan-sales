class AddProductTypeToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_type, :integer, default: 0
    add_column :products, :duration, :integer, default: 0
    add_column :products, :duration_quantity, :integer
  end
end
