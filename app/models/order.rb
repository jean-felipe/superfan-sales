# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  code           :string
#  payment_method :string
#  status         :integer
#  total_price    :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint           not null
#  table_id       :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_orders_on_company_id  (company_id)
#  index_orders_on_table_id    (table_id)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (table_id => tables.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  STATUSES = %w(initialized open cancelled finished)
  
  belongs_to :user
  belongs_to :company
  belongs_to :table

  has_many :items, class_name: "OrderItem"

  enum status: STATUSES
end
