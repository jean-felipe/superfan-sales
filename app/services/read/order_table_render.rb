module Read
  class OrderTableRender
    class << self
      def render(order)
        {
          id: order.id,
          order_number: order.code,
          status: order.status,
          table_name: order.table.name,
          total_price: order.total_price,
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
          end
        }
      end
    end
  end
end