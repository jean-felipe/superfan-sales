module Api::V1
  class AdminController < Api::BaseController
    def clients
      render json: Read::AdminReader.clients
    end

    def company
      render json: Read::AdminReader.get_company(params[:id])
    end
  end
end
