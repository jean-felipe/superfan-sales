class AddPriceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price, :float
    add_column :products, :has_discount, :boolean, default: false
    add_column :products, :discount_price, :float
  end
end
