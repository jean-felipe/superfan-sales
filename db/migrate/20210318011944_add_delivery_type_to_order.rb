class AddDeliveryTypeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_type, :integer, default: 0
  end
end
