class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_company
    current_user.company
  end

  def user_info
    {
      user: current_user,
      company: {
        id: current_company.id,
        description: current_company.description,
        document: current_company.document,
        fantasy_name: current_company.fantasy_name,
        legal_name: current_company.legal_name,
        phone: current_company.phone,
        created_at: current_company.created_at.strftime("%d/%m/%Y"),
        segment: current_company.segment.name,
      }
    }
  end

end
