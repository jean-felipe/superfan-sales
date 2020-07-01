module Api::V1
  class CompaniesController < Api::BaseController
    def create
      @company = Company.new(company_params)
      @company.user = current_user

      if @company.save
        render json: @company
      else
        render json: @company.errors.message, status: 422
      end
    end

    private

    def company_params
      params.permit(:description, :document, :fantasy_name, :legal_name, :phone, :segment_id)
    end
  end
end