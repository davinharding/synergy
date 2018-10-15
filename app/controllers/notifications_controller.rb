class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = Notification.where(recipient: current_user.profile).unread.count
    @profiles = current_user.profile&.notifications&.unread&.map(&:actor)&.uniq || []
    respond_to do |format|
      format.json do 
        render json: { notifications: @notifications, profiles: @profiles }
      end
    end
  end
end