class AddCompanyIdToOrderPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :order_payments, :company_id, :bigint
  end
end
