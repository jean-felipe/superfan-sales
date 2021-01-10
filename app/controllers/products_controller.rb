class ProductsController < ApplicationController
  before_action :load_product, only: [:edit]

  def index
    @products = current_user.company.products.map do |product|
      {
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        quantity: product.quantity
      }
    end

    @props = {
      component_name: 'products_list',
      component_data: [@products],
      user: user_info
    }
  end

  def new
    values = {
      categories: Category.select(:id, :name).as_json,
      sub_categories: SubCategory.select(:id, :name).as_json,
      unities: Product::UNITIES.map {|un| {unit: un, name: Product.human_enum_name(:measure_unities, un)}}
    }

    @props = {
      component_name: 'product_form',
      component_data: [values],
      user: user_info
    }
  end

  def edit
    values = {
      categories: Category.select(:id, :name).as_json,
      sub_categories: SubCategory.select(:id, :name).as_json,
      unities: Product::UNITIES.map {|un| {unit: un, name: Product.human_enum_name(:measure_unities, un)}},
      product: @product,
      edition: true
    }

    @props = {
      component_name: 'product_form',
      component_data: [values],
      user: user_info
    }
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end
end