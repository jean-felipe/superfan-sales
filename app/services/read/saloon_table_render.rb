module Read
  class SaloonTableRender
    class << self
      def render(table)
        {
          id: table.id,
          name: table.name,
          places: table.places,
          status: table.active? ? 'Ativa' : 'Inativa',
          created_at: table.created_at.strftime('%d/%m/%y'),
        }
      end
    end
  end
end