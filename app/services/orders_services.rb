class OrdersServices
  class << self
    def create(params, company_id)
      @order = Order.new(
        code: SecureRandom.hex(4),
        status: 'initialized',
        total_price: params[:items].map {|o| o[:price].nil? ? 0 : o[:price] }.inject(0, :+),
        table_id: params[:table_id],
        company_id: company_id,
        user_id: UserServices.load_or_create(params[:identification]).id
      )

      if @order.save
        create_items(params[:items])
        @order
      else
        @order.errors.messages
      end
    end

    def update(params, order)
      @order = order

      if params[:items].present?
        create_items(params[:items])
        @order.update(total_price: @order.items.sum(:price))
      end

      if params[:identification].present? && params[:identification] != @order.user.document
        @order.user.update(document: params[:identification])
      end
    end

    private

    def create_items(items)
      items.each do |item|
        OrderItem.create!(
          code: SecureRandom.hex(6),
          price: item[:price],
          quantity: item[:quantity],
          order_id: @order.id,
          product_id: item[:id]
        )
      end      
    end
  end
end