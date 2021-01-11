module Api::V1
  class ImportationsController < Api::BaseController
    def products
      errors = Importations::Product.import(params[:file].tempfile, current_company)

      if errors.empty?
        render json: "sucess"
      else
        render json: { errors: errors }
      end
    end
  end
end