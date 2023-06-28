class SubscriptionsController < ApplicationController
  before_action :load_service, except: %i[create index]
  before_action :load_subscription, only: %i[show edit]

  def index
    @services = current_user.company.service_definitions

    @props = {
      component_name: 'services_list',
      component_data: [list_response],
      user: user_info
    }
  end

  def product_config
    service = Product.find(params[:product_id])

    @props = {
      component_name: 'product_service_definition',
      component_data: { service: },
      user: user_info
    }
  end

  def new
    @props = {
      component_name: 'subscription_form',
      component_data: { service: @service },
      user: user_info
    }
  end

  def edit
    @props = {
      component_name: 'subscription_form',
      component_data: { edit: true, service_id: @service.id },
      user: user_info
    }
  end

  def show
    @props = {
      component_name: 'subscription_detail',
      component_data: subscription_details,
      user: user_info
    }
  end

  private

  def load_service
    @service = ServiceDefinition.find(params[:service_definition_id])
  end

  def load_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_details
    {
      client: @subscription.client.details,
      service: @subscription.service_definition,
      subscription: {
        id: @subscription.id,
        additional_details: @subscription.additional_details,
        end_at: @subscription.end_at.strftime("%d/%m/%Y"),
        pay_at: @subscription.pay_at,
        start_at: @subscription.start_at.strftime("%d/%m/%Y"),
        start_payment: @subscription.start_payment,
        status: @subscription.status
      }
    }
  end

  def list_response
    {
      pages: @services.count / 10,
      current_page: params[:page].to_i || 1,
      service_id: @service.id,
      services: @services.limit(10).page(params[:page]).map do |service|
        {
          id: service.id,
          name: service.name,
          description: service.description,
          price: 'R$ ' + service.price.to_s,
        }
      end
    }
  end

  def subscriptions_list
    {
      pages: @subscriptions.count / 10,
      current_page: params[:page].to_i || 1,
      product_name: @service.name,
      product_id: @service.id,
      subscriptions: @subscriptions.limit(10).page(params[:page]).map do |sub|
        {
          id: sub.id,
          client_name: sub.client.name,
          start_at: sub.start_at.strftime("%d/%m/%Y"),
          end_at: sub.end_at.strftime("%d/%m/%Y"),
          status: sub.status
        }
      end
    }
  end
end
