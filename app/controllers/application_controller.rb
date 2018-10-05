class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :send_user_to_create_profile_unless_profile_exists

  private

  def send_user_to_create_profile_unless_profile_exists
    unless devise_controller? || current_user.profile
      redirect_to new_profile_path
    end
  end
end
