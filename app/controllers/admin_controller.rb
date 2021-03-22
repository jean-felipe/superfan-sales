class AdminController < ApplicationController
  def index
    @props = {
      component_name: 'admin_clients',
      component_data: [{clients: Read::AdminReader.list_clients}],
      user: user_info
    }
  end
end
