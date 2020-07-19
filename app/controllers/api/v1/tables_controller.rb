module Api::V1
  class TablesController < Api::BaseController
    def create
      @table = Table.new(table_params)
      @table.company = current_user.company

      if @table.save
        render json: @table, status: 201
      else
        render json: @table.errors.messages, status: 422
      end

    end

    private

    def table_params
      params.require(:table).permit(
        :name, :places, :status
      )
    end
  end
end