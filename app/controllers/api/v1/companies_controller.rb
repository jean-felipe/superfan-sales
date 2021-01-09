module Api::V1
  class CompaniesController < Api::BaseController
    before_action :load_company

    def create
      @company = Company.new(company_params)
      @company.user = current_user

      if @company.save
        render json: @company
      else
        render json: @company.errors.messages, status: 422
      end
    end

    def update
      if @company.update(company_params)
        render json: @company
      else
        render json: @company.errors.messages, status: 422
      end
    end

    private

    def company_params
      params.permit(:description, :document, :fantasy_name, :legal_name, :phone, :segment_id)
    end

    def load_company
      @company = Company.find(params[:id])
    end
  end
end