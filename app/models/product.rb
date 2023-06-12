# == Schema Information
#
# Table name: products
#
#  id                :bigint           not null, primary key
#  description       :text             not null
#  discount_price    :float
#  duration          :integer          default(0)
#  duration_quantity :integer
#  ean               :string           not null
#  has_discount      :boolean          default(FALSE)
#  is_active         :boolean          default(TRUE)
#  measure           :float
#  measure_unit      :integer          default("grams")
#  name              :string           not null
#  price             :float
#  product_type      :integer          default("product")
#  quantity          :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  company_id        :bigint           not null
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
  UNITIES = %w[grams kg liters ml unit time].freeze
  TYPES = %w[product service].freeze

  belongs_to :company
  has_and_belongs_to_many :sub_categories
  has_and_belongs_to_many :categories

  has_many :subscriptions

  has_one :service_definition

  enum measure_unit: UNITIES
  enum product_type: TYPES

  validates :ean, uniqueness: { scope: :name }

  before_save :set_product_type

  def set_product_type
    return if categories.map { |category| category.name == 'Servico' }.empty?

    service!
  end
end
