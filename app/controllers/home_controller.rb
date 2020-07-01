class HomeController < ApplicationController
  def index
    @props = {
      component_name: 'products',
      user: user_info
    }
  end
end
