class ServiceDefinitionsController < ApplicationController
  before_action :load_product, except: [:create, :index, :new]

  def index
    @services = current_user.company.products.service

    @props = {
      component_name: 'services_list',
      component_data: [list_response],
      user: user_info
    }
  end

  def product_config
    @product = Product.find(params[:product_id])

    @props = {
      component_name: 'product_service_definition',
      component_data: { product: @product },
      user: user_info
    }
  end

  def new
    @props = {
      component_name: 'subscription_form',
      component_data: { product: @product },
      user: user_info
    }
  end

  def edit
    @service = @product.service_definition || @product.service_definition.new

    @props = {
      component_name: 'product_service_definition',
      component_data: { product: @product },
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
    @subscriptions = @product.subscriptions.includes(:client, :product)

    @props = {
      component_name: 'subscriptions_list',
      component_data: [subscriptions_list],
      user: user_info
    }
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
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
          quantity: service.quantity
        }
      end
    }
  end

  def subscriptions_list
    {
      pages: @subscriptions.count / 10,
      current_page: params[:page].to_i || 1,
      product_name: @product.name,
      product_id: @product.id,
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
