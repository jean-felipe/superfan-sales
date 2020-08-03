class UserServices
  class << self
    def load_or_create(identification)
      user = User.find_by(document: identification)

      if user.nil?
        user = User.new(
          document: identification,
          password: 'qweqwe123',
          email: "#{SecureRandom.hex(4)}@email.com",
          name: "#{SecureRandom.hex(4)}",
          code: "#{SecureRandom.hex(4)}"
        )
        
        if user.save
          user
        end
      else
        user
      end
    end
  end
end