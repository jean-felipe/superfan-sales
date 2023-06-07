# == Schema Information
#
# Table name: service_definitions
#
#  id          :bigint           not null, primary key
#  code        :string
#  definitions :jsonb
#  status      :integer          default(0)
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
require 'rails_helper'

RSpec.describe ServiceDefinition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end