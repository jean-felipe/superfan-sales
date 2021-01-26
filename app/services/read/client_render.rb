module Read
  class ClientRender
    class << self
      def render_from_array(array)
        array.map do |client|
          {
            id: client.id,
            code: client.user.code,
            name: client.user.name,
            email: client.user.email,
            document: client.user.document,
            gender: client.user.gender,
          }
        end
      end

      def render_single(client)
        {
          id: client.id,
          code: client.user.code,
          name: client.user.name,
          email: client.user.email,
          document: client.user.document,
          gender: client.user.gender,
          birthdate: client.user.birthdate&.strftime("%Y-%m-%d")
        }
      end
    end
  end
end