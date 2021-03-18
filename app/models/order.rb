# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  code           :string
#  delivery_type  :integer          default(0)
#  payment_method :string
#  status         :integer
#  total_price    :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint           not null
#  table_id       :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_orders_on_company_id  (company_id)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  STATUSES = %w(initialized open cancelled payed)
  DTYPES = %w(not_registred grab delivery local)

  belongs_to :user
  belongs_to :company
  belongs_to :table, optional: true

  has_many :items, class_name: "OrderItem"
  has_many :payments, class_name: "OrderPayment"
  has_many :products, through: :items

  enum status: STATUSES
  enum delivery_type: DTYPES

  scope :actives, -> { where(status: %w(initialized open))}
end
