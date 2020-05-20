class HomeController < ApplicationController
  def index
    @props = {
      component_name: 'products',
      user: current_user
    }
  end
end
