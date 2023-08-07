class ClientsServices
  class << self
    def create(company_id, user_id)
      verify_client(company_id, user_id)

      if @client.nil?
        Client.create(company_id: company_id, user_id: user_id)
      end
    end

    def search(company, params)
      if params[:document]
        handle_response(company.users.where("document like ?", "%#{params[:document]}%").first)
      else
        handle_response(company.users.where("email like ?", "%#{params[:email]}%").first)
      end
    end

    private

    def handle_response(user)
      return {} if user.nil?

      {
        {
          id: user.id,
          name: user.name,
          email: user.email,
          gender: user.gender,
          document: user.document,
          birthdate: user.birthdate.strftime('%Y-%m-%d')
        }
      }
    end

    def verify_client(company_id, user_id)
      @client = Client.find_by(company_id: company_id , user_id: user_id)
    end
  end
end
