module Api::V1
  class TablesController < Api::BaseController
    before_action :load_table

    def create
      @table = Table.new(table_params)
      @table.company = current_user.company

      if @table.save
        render json: @table, status: 201
      else
        render json: @table.errors.messages, status: 422
      end

    end

    def show
      render json: Read::SaloonTableRender.render(@table), status: 200
    end

    private

    def table_params
      params.require(:table).permit(
        :name, :places, :status
      )
    end

    def load_table
      @table = Table.find(params[:id])
    end
  end
end