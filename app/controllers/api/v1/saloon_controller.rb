module Api::V1
  class SaloonController < Api::BaseController
    def index
      @tables = current_user.company.tables.map { |t| Read::SaloonTableRender.render(t) }

      render json: @tables, status: 200
    end
  end
end