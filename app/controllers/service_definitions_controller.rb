class ServiceDefinitionsController < ApplicationController
  before_action :load_product

  def index
    @products = current_user.company.products.service

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

  private

  def load_product
    @product = Product.find(params[:product_id])
  end

  def list_response
    {
      pages: @products.count / 10,
      current_page: params[:page].to_i || 1,
      products: @products.limit(10).page(params[:page]).map do |product|
        {
          id: product.id,
          name: product.name,
          description: product.description,
          price: 'R$ ' + product.price.to_s,
          quantity: product.quantity
        }
      end
    }
  end
end
