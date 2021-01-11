class Api::BaseController < ActionController::API
  def current_company
    current_user.company
  end
end