class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :client, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.boolean :start_payment
      t.date :pay_at, null: false
      t.jsonb :additional_details, default: {}
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
