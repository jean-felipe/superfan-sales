module Api::V1
  class CategoriesController < Api::BaseController
    def create
      @category = Category.new(category_params)

      if @category.save
        render json: @category, status: 201
      else
        render json: @category.errors.messages, status: 422
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
