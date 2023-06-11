class ProductsController < ApplicationController
  before_action :load_product, only: [:edit]
  before_action :check_company

  def index
    @products = current_user.company.products.order(:id)

    @props = {
      component_name: 'products_list',
      component_data: [list_response],
      user: user_info
    }
  end

  def new
    values = {
      categories: Category.select(:id, :name).order(:name).as_json,
      sub_categories: SubCategory.select(:id, :name).as_json,
      unities: Product::UNITIES.map { |un| { unit: un, name: Product.human_enum_name(:measure_unities, un) } }
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
      unities: Product::UNITIES.map { |un| { unit: un, name: Product.human_enum_name(:measure_unities, un) } },
      product: @product,
      product_category: @product.categories&.first&.id,
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
