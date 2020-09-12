class ClientsServices
  class << self
    def create(company_id, user_id)
      verify_client(company_id, user_id)

      if @client.nil?
        Client.create(company_id: company_id, user_id: user_id)
      end
    end

    def search(params)
      if params[:document]
        handle_response(User.where("document like ?", params[:document]).first)
      else
        handle_response(User.where("email like ?", params[:email]).first)
      end
    end

    private

    def handle_response(user)
      return {} if user.nil?

      {
        user: {
          name: user.name,
          email: user.email,
          gender: user.gender,
          document: user.document,
          birthdate: user.birthdate.strftime('%Y-%m-%d'),
        }
      }
    end

    def verify_client(company_id, user_id)      
      @client = Client.find_by(company_id: company_id , user_id: user_id)
    end
  end
end