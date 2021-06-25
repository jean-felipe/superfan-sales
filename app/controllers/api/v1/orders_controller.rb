module Api::V1
  class OrdersController < Api::BaseController
    before_action :load_order, only: [:show, :update]

    def create

      binding.pry

      render json: ::OrdersServices.create(order_params, current_company.id, current_company.segment.name), status: 201
    end

    def show
      render json: Read::OrderTableRender.render(@order)
    end

    def update
      render json: ::OrdersServices.update(order_params, @order), status: 200
    end

    private

    def order_params
      params.require(:order).permit(
        :id, :identification, :description, :identification_type, :checkout_date, :delivery_type, :table_id, :items => [:id, :name, :quantity, :price],
        :payment_methods => [:name, :value]
      )
    end

    def load_order
      @order = Order.find(params[:id])
    end
  end
end
