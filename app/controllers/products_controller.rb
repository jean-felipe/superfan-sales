class ProductsController < ApplicationController
  def index
    @props = {
      component_name: 'products_list',
      component_data: [Product.all],
      user: current_user
    }
  end
end