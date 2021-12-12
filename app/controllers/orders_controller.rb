class OrdersController < ApplicationController
  before_action :load_order, only: :show
  before_action :check_company

  def index
    @orders = current_company.orders.order(created_at: :desc).map { |o| Read::OrderTableRender.render(o) }

    @props = {
      component_name: 'orders_list',
      component_data: [@orders],
      user: user_info
    }
  end

  def new
    @props = {
      component_name: 'order_form',
      component_data: [],
      user: user_info
    }
  end

  def show
    @props = {
      component_name: 'show_order',
      component_data: [@order],
      user: user_info
    }
  end

  private

  def load_order
    @order = Read::OrderTableRender.render(Order.find(params[:id]))
  end
end
