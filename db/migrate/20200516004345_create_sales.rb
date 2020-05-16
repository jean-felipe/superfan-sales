class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :logged_user, null:false
      t.integer :payment_method, null:false
      t.datetime :transaction_date, null:false, default: Time.now

      t.timestamps
    end
  end
end
