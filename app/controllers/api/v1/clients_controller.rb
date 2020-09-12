module Api::V1
  class ClientsController < Api::BaseController
    before_action :load_user_by_email, only: :create

    def create      
      if @user.present?
        if @user.update(clients_params)
          create_client(@user)
          render_object(@user, 200)
        else
          render_object(@user.errors.messages, 422)
        end
      else
        @client = User.new(clients_params)

        if @client.save
          create_client(@client)
          render_object(@client, 201)
        else
          render_object(@client.errors.messages, 422)
        end
      end
    end

    def index
      @clients = ClientsServices.search(params[:filter])
      render_object(@clients, 200)
    end

    private

    def clients_params
      params.require(:client).permit(
        :name, :email, :document, :gender, :birthdate
      )
    end

    def load_user_by_email
      @user = User.find_by(email: params.dig('client', 'email'))
      @user.nil?
      @user = User.find_by(document: params.dig('client', 'document'))
    end

    def render_object(object, status)
      render json: object, status: status
    end

    def create_client(user)
      ClientsServices.create(current_user.company.id, user.id)
    end
  end
end