module Api::V1
  class ProductsController < Api::BaseController
    def create
      @product = Product.new(product_params)

      if @product.save
        render json: @product, status: 201
      else
        render json: @product.errors.messages, status: 422
      end
    end

    private

    def product_params
      params.require(:product).permit(
        :description, :ean, :is_active, :name, :categories[]
      )
    end
  end
end