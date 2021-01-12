module Customers
  class Create
    class << self
      def instantiate_foo_customer(user)
        user.code = SecureRandom.hex(4)
        user.password = 'alterarSenha'
        user.user_type = 'customer'
        user
      end
    end
  end
end