# == Schema Information
#
# Table name: subscriptions
#
#  id                    :bigint           not null, primary key
#  additional_details    :jsonb
#  end_at                :datetime         not null
#  pay_at                :integer          not null
#  start_at              :datetime         not null
#  start_payment         :boolean
#  status                :integer          default("active")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  client_id             :bigint           not null
#  company_id            :bigint           not null
#  service_definition_id :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_client_id              (client_id)
#  index_subscriptions_on_company_id             (company_id)
#  index_subscriptions_on_service_definition_id  (service_definition_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (service_definition_id => service_definitions.id)
#
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
