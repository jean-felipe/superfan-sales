module Read
  class SaloonTableRender
    class << self
      def render(table)
        {
          id: table.id,
          name: table.name,
          places: table.places,
          status: table.active? ? 'Ocupada' : 'Livre',
          created_at: table.created_at.strftime('%d/%m/%y'),
        }
      end

      def render_for_order(table)
         {
          id: table.id,
          name: table.name,
          places: table.places,
          status: table.active? ? 'Ocupada' : 'Livre',
          created_at: table.created_at.strftime('%d/%m/%y'),
        }
      end
    end
  end
end