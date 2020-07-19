class SaloonController < ApplicationController
  def index
    @tables = current_user.company.tables.map { |t| Read::SaloonTableRender.render(t) }

    @props = {
      component_name: 'saloon',
      component_data: [@tables],
      user: user_info
    }
  end

  def new
    @props = {
      component_name: 'table_form',
      component_data: [],
      user: user_info
    }
  end

  def edit
    
  end
end