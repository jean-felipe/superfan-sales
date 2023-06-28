# == Schema Information
#
# Table name: service_definitions
#
#  id             :bigint           not null, primary key
#  code           :string
#  definitions    :jsonb
#  description    :string
#  discount_price :float
#  has_discount   :boolean          default(FALSE)
#  name           :string
#  price          :float
#  service_type   :integer          default("class")
#  status         :integer          default("active")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint           not null
#
# Indexes
#
#  index_service_definitions_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class ServiceDefinition < ApplicationRecord
  STATUSES = %w[active inactive].freeze
  TYPES = %w[class on_demand stream].freeze

  belongs_to :company

  has_many :subscriptions

  enum status: STATUSES
  enum service_type: TYPES
end
