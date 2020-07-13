class ProductsController < ApplicationController
  def index
    @products = current_user.company.products

    @props = {
      component_name: 'products_list',
      component_data: [@products],
      user: user_info
    }
  end

  def new
    values = {
      categories: Category.select(:id, :name).as_json,
      sub_categories: SubCategory.select(:id, :name).as_json
    }
    
    @props = {
      component_name: 'product_form',
      component_data: [values],
      user: user_info
    }
  end
end