class RemoveTableIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_index :orders, name: "index_orders_on_table_id"
  end
end
