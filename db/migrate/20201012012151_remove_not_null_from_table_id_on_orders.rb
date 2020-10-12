class RemoveNotNullFromTableIdOnOrders < ActiveRecord::Migration[6.0]
  def change
     change_column_null :orders, :table_id, true
     remove_foreign_key :orders, column: :table_id
  end
end
