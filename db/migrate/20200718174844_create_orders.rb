class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.integer :status
      t.float :total_price
      t.string :payment_method

      t.timestamps
    end
  end
end
