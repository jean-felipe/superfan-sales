class ProductsController < ApplicationController
  def index
    @props = {
      component_name: 'products_list',
      component_data: [Product.all],
      user: current_user
    }
  end

  def new
    @props = {
      component_name: 'product_form',
      component_data: [Product.new],
      user: current_user
    }
  end
end