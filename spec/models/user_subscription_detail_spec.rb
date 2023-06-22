# == Schema Information
#
# Table name: user_subscription_details
#
#  id                 :bigint           not null, primary key
#  total_available    :integer
#  total_month_period :string
#  total_used         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  subscription_id    :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_user_subscription_details_on_subscription_id  (subscription_id)
#  index_user_subscription_details_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => subscriptions.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserSubscriptionDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
