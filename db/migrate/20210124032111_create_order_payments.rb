class CreateOrderPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :order_payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :payer_document
      t.decimal :value
      t.integer :payment_type, default: 0

      t.timestamps
    end
  end
end
