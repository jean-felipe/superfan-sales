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
      component_data: [company_info],
      user: user_info
    }
  end

  def edit
    @props = {
      component_name: 'company_form',
      component_data: [{company: company_info, segments: Segment.select(:id, :name).as_json}],
      user: user_info
    }
  end

  def daily_report
    @props = {
      component_name: 'daily_report',
      component_data: [],
      user: user_info
    }
  end
end