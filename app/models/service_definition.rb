# == Schema Information
#
# Table name: service_definitions
#
#  id          :bigint           not null, primary key
#  code        :string
#  definitions :jsonb
#  status      :integer          default("active")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_service_definitions_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class ServiceDefinition < ApplicationRecord
  STATUSES = %w[active inactive].freeze

  belongs_to :product

  enum status: STATUSES
end
