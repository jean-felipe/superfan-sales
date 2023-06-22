class SubscriptionsServices
  class << self
    def create_subscriptions_details(user, subscription)
      details = UserSubscriptionDetail.new(user: user, subscription: subscription)

      details.total_available = subscription.additional_details
      details.total_month_period
      details.total_used

    end
  end
end
