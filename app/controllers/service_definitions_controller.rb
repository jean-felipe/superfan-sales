class ServiceDefinitionsController < ApplicationController
  before_action :load_service, except: [:create, :index, :new]

  def index
    @services = current_user.company.service_definitions

    @props = {
      component_name: 'services_list',
      component_data: [list_response],
      user: user_info
    }
  end

  def product_config
    @service = Product.find(params[:product_id])

    @props = {
      component_name: 'product_service_definition',
      component_data: { product: @service },
      user: user_info
    }
  end

  def new
    @props = {
      component_name: 'service_form',
      component_data: { product: @service },
      user: user_info
    }
  end

  def edit
    @service = @service.service_definition || @service.service_definition.new

    @props = {
      component_name: 'product_service_definition',
      component_data: { product: @service },
      user: user_info
    }
  end

  def create
  end

  def update
  end

  def delete
  end

  def show
    @subscriptions = @service.subscriptions.includes(:client)

    @props = {
      component_name: 'subscriptions_list',
      component_data: [subscriptions_list],
      user: user_info
    }
  end

  private

  def load_service
    @service = ServiceDefinition.find(params[:id])
  end

  def list_response
    {
      pages: @services.count / 10,
      current_page: params[:page].to_i || 1,
      services: @services.limit(10).page(params[:page]).map do |service|
        {
          id: service.id,
          name: service.name,
          description: service.description,
          price: 'R$ ' + service.price.to_s,
          quantity: service.definitions[:quantity]
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
