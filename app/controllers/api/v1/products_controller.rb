module Api::V1
  class ProductsController < Api::BaseController
    def create
      @product = Product.new(product_params)
    end

    private

    def product_params
      params.require(:product).permit(
        :description, :ean, :is_active, :name
      )
    end
  end
end