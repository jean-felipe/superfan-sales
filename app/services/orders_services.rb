class OrdersServices
  class << self
    def create(params, company_id, type)
      @order = Order.new(
        code: SecureRandom.hex(4),
        status: load_initial_state(type),
        total_price: params[:items].map {|o| o[:price].nil? ? 0 : o[:price] }.inject(0, :+),
        table_id: params[:table_id].nil? ? 1 : params[:table_id],
        company_id: company_id,
        delivery_type: load_delivery_type(params[:delivery_type]),
        user_id: UserServices.load_or_create(params[:identification], params[:identification_type]).id
      )

      if @order.save
        create_client(@order.user_id, company_id)
        create_items!(params[:items])
        create_payments(params[:payment_methods], company_id)
        @order.update(total_price: @order.items.sum(:total_price))
        @order
      else
        @order.errors.messages
      end
    end

    def update(params, order)
      @order = order

      if params[:items].present?
        create_items!(params[:items])
        @order.update(total_price: @order.items.sum(:total_price))
      end

      if params[:identification].present? && params[:identification] != @order.user.document
        @order.user.update(document: params[:identification])
      end
    end

    private

    def create_items!(items)
      items.each do |item|
        existing_item = @order.items.find_by(product_id: item[:id])

        if existing_item.nil?
          OrderItem.create!(
            code: SecureRandom.hex(6),
            price: item[:price],
            quantity: item[:quantity],
            order_id: @order.id,
            product_id: item[:id],
            total_price: item[:price].to_i * item[:quantity].to_i
          )
        else
          existing_item.quantity += item[:quantity]
          existing_item.save!
        end
      end
    end

    def create_client(user_id, company_id)
      Client.create(user_id: user_id, company_id: company_id)
    end

    def create_payments(payments, company_id)
      payments.each do |payment|
        OrderPayment.create!(
          payment_type: load_payment_type(payment[:name]),
          value: payment[:value],
          company_id: company_id,
          order: @order
        )
      end
    end

    def load_initial_state(type)
      case type
      when 'Mercados' then 'payed'
      when 'Restaurantes' then 'initialized'
      end
    end

    def load_payment_type(type)
      case type
      when 'Crédito' then 'credit'
      when 'Débito' then 'debit'
      when 'Dinheiro' then 'money'
      end
    end

    def load_delivery_type(type)
      case type
      when 'Entrega' then 'delivery'
      when 'Retirada' then 'grab'
      when 'Consumo no local' then 'local'
      end
    end
  end
end
