class ClientsController < ApplicationController
  before_action :load_client, only: :edit

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

  def edit
     @props = {
      component_name: 'client_form',
      component_data: [{client: Read::ClientRender.render_single(@client), edit: true}],
      user: user_info
    }
  end

  private

  def load_client
    @client = current_company.clients.find(params[:id])
  end
end