module Api::V1
  class ProductsController < Api::BaseController
    before_action :load_product, only: :update

    def create
      @product = Product.new(product_params)
      @product.company = current_user.company
      @product.category_ids << product_params[:category_id]

      if @product.save
        render json: @product, status: 201
      else
        render json: @product.errors.messages, status: 422
      end
    end

    def update
      if @product.update(product_params)
        render json: @product, status: 200
      else
        render json: @product.errors.messages
      end
    end

    def index
      @products = current_user.company.products
        .where("name like ?", "%#{params[:filter]}%")
        .select(params[:fields].split(',')).as_json

      render json: @products, status: 200
    end

    private

    def product_params
      params.require(:product).permit(
        :description, :ean, :is_active, :name, :category_id, :price, :has_discount, :discount_price,
        :quantity, :id, :measure, :measure_unit, :duration, :duration_quantity
      )
    end

    def load_product
      @product = Product.find(params[:id])
    end
  end
end
