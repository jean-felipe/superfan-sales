class CreateUserSubscriptionDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscription_details do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.integer :total_used
      t.integer :total_available
      t.string :total_month_period

      t.timestamps
    end
  end
end
