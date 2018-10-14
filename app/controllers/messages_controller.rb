class MessagesController < ApplicationController
  before_action :set_profile
  skip_before_action :verify_authenticity_token

  def create
    message = @profile.received_messages.create(
      sender:   current_user.profile,
      content:  message_params[:content]
    )
    Notification.create(recipient: @profile, actor: current_user.profile, action: "messaged")  

    render json: message
  end

  def index
    @messages = Message.between(@profile, current_user.profile)
    @channel = "messages:#{[@profile.id, current_user.profile.id].sort.join(':')}"
    respond_to do |format|
      format.html do
        @message  = Message.new
      end
      format.json do
        render json:  @messages.map{|m| m.attributes.merge(sender: m.sender.attributes, recipient: m.recipient.attributes) }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
