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

    def upload_images
      
      # binding.pry
      
    end

    private

    def product_params
      params.permit(
        :description, :ean, :is_active, :name, :category_id
      )
    end

    def load_product
      @product = Product.find(params[:id])
    end
  end
end