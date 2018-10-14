class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages:#{params['profile_1_id']}:#{params['profile_2_id']}"
  end

  def unsubscribed
    stop_all_streams
  end
end
