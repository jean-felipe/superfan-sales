# == Schema Information
#
# Table name: companies
#
#  id           :bigint           not null, primary key
#  description  :string
#  document     :string
#  fantasy_name :string
#  legal_name   :string
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  segment_id   :integer
#  user_id      :bigint           not null
#
# Indexes
#
#  index_companies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Company < ApplicationRecord
  belongs_to :user
  belongs_to :segment

  has_many :products
  has_many :tables
  has_many :orders
  has_many :clients
  has_many :service_definitions
  has_many :users, through: :clients
  has_many :order_payments, through: :orders, source: 'order_id'
end
