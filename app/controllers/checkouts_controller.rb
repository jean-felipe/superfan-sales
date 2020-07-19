class CheckoutsController < ApplicationController
  def index
    @props = {
      component_name: 'checkout',
      component_data: [current_user.company.products],
      user: user_info
    }
  end

  def new
    @props = {
      component_name: 'company_form',
      component_data: [{segments: Segment.select(:id, :name).as_json}],
      user: user_info
    }
  end
end