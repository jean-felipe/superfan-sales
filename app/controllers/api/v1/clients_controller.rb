module Api::V1
  class ClientsController < Api::BaseController
    def create
      # client = 
      #   render json: 
    end

    def index
      
      binding.pry
      
      @clients = current_user.company.clients.where("#{param[:filter]} like ?", "%#{params[:filter]}%").select(:id, :name, :price).as_json
    end

    private

    def clients_params
      params.require(:client).permit(
        :name, :email, :document, :gender, :birthdate
      )
    end
  end
end