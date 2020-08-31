class ClientsController < ApplicationController
  def index
    @props = {
      component_name: 'clients_list',
      component_data: [{clients: Read::ClientRender.render_from_array(current_user.company.clients)}],
      user: user_info
    }
  end

  def new
     @props = {
      component_name: 'client_form',
      user: user_info
    }
  end
end