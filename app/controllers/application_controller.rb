class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_company
    current_user.company
  end

  def user_info
    {
      user: current_user,
      company: current_company
    }
  end

end
