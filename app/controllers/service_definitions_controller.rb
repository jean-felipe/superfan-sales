class ServiceDefinitionsController < ApplicationController
  before_action :load_product

  def index
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
end
