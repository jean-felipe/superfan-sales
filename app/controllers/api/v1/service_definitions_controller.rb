module Api::V1
  class ServiceDefinitionsController < Api::BaseController
    def create
      @service = ServiceDefinition.new(service_definitions_params)

      @service.company = current_company

      if @service.save
        render json: @service, status: 201
      else
        render json: @service.errors.messages, status: 422
      end
    end

    private

    def service_definitions_params
      params.require(:service_definition).permit(
        :name, :description, :price, :has_discount, :service_type, definitions: {}
      )
    end
  end
end
