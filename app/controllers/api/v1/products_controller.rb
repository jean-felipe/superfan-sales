module Api::V1
  class ProductsController < Api::BaseController
    def create
      @product = Product.new(product_params)
      @product.company = current_user.company
      
      if @product.save
        render json: @product, status: 201
      else
        render json: @product.errors.messages, status: 422
      end
    end

    private

    def product_params
      params.permit(
        :description, :ean, :is_active, :name, :category_id
      )
    end
  end
end