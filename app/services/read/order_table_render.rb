module Read
  class OrderTableRender
    class << self
      def render(order)
        {
          id: order.id,
          order_number: order.code,
          status: Order.human_enum_name(:status, order.status),
          table_name: order.table&.name,
          total_price: order.total_price,
          delivery_type: Order.human_enum_name(:delivery_type, order.delivery_type),
          created_at: order.created_at.strftime("%d/%m/%Y %H:%M"),
          user: {
            name: order.user.name,
            email: order.user.email,
            document: order.user.document,
            code: order.user.code
          },
          items: order.items.map do |item|
            {
              code: item.code,
              price: item.price,
              quantity: item.quantity,
              product: item.product.name
            }
          end,
          payments: order.payments.map do |payment|
            {
              name: OrderPayment.human_enum_name(:payment_type, payment.payment_type),
              value: payment.value
            }
          end
        }
      end
    end
  end
end
