module Api::V1
  class OrdersController < Api::BaseController
    def create      
      render json: ::OrdersServices.create(order_params, current_user.company.id), status: 201
    end

    private

    def order_params
      params.require(:order).permit(
        :id, :identification, :description, :table_id, :items => [:id, :name, :quantity, :price]
      )
    end
  end
end
