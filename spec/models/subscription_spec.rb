# == Schema Information
#
# Table name: subscriptions
#
#  id                 :bigint           not null, primary key
#  additional_details :jsonb
#  end_at             :datetime         not null
#  pay_at             :date             not null
#  start_at           :datetime         not null
#  start_payment      :boolean
#  status             :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :bigint           not null
#  product_id         :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_client_id   (client_id)
#  index_subscriptions_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (product_id => products.id)
#
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
