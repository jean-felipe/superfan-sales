class UserServices
  class << self
    def load_or_create(identification, identification_type)

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

    private

    def load_by_name(name)
      User.find_by(name: name)
    end

    def load_by_document(document)
      User.find_by(document: document)
    end
  end
end
