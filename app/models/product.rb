# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  description    :text             not null
#  discount_price :float
#  ean            :string           not null
#  has_discount   :boolean          default(FALSE)
#  is_active      :boolean          default(TRUE)
#  measure        :float
#  measure_unit   :integer          default("grams")
#  name           :string           not null
#  price          :float
#  quantity       :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint           not null
#
# Indexes
#
#  index_products_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Product < ApplicationRecord
  UNITIES = %w(grams kg liters ml unit)

  belongs_to :company
  has_and_belongs_to_many :sub_categories
  has_and_belongs_to_many :categories

  enum measure_unit: UNITIES

  validates :ean, uniqueness: { scope: :name }
end
