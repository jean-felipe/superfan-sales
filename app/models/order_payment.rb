# == Schema Information
#
# Table name: order_payments
#
#  id             :bigint           not null, primary key
#  payer_document :string
#  payment_type   :integer          default("debit")
#  value          :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint
#  order_id       :bigint           not null
#
# Indexes
#
#  index_order_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class OrderPayment < ApplicationRecord
  TYPES = %w(debit credit money pix)
  belongs_to :order

  has_one :company, through: :order

  enum payment_type: TYPES
end
