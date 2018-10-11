class MessagesController < ApplicationController
  before_action :set_profile

  def create
    @profile.received_messages.create(
      sender:   current_user.profile,
      content:  message_params[:content]
    )
    redirect_to profile_messages_path(@profile)
  end

  def index
    @messages = Message.between(@profile, current_user.profile)
    @message  = Message.new
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
