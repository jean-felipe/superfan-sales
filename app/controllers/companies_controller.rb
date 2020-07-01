class CompaniesController < ApplicationController
  def new
    @props = {
      component_name: 'company_form',
      component_data: [{segments: Segment.select(:id, :name).as_json}],
      user: user_info
    }
  end

  def show
    @props = {
      component_name: 'company_info',
      component_data: [current_user.company],
      user: user_info
    }
  end

  def edit
    @props = {
      component_name: 'company_edition',
      component_data: [current_user.company],
      user: user_info
    }
  end
end