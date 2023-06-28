module Api::V1
  class SubscriptionsController < Api::BaseController
    def create
      @subscription = Subscription.new(subscription_params)

      @subscription.client = load_customer
      @subscription.company = current_company
      @subscription.pay_at = extract_pay_day

      if @subscription.save

        render json: @subscription, status: 201
      else
        render json: @subscription.errors.messages, status: 422
      end
    end

    private

    def subscription_params
      params.require(:subscription).permit(
        :id, :client_id, :start_at, :end_at, :service_definition_id, :pay_at, :start_payment, additional_details: {}
      )
    end

    def load_customer
      @client = Client.find_by(user_id: subscription_params[:client_id], company_id: current_company.id)
    end

    def extract_pay_day
      date_string = subscription_params['pay_at']
      date = Date.parse(date_string)
      date.day
    end
  end
end
