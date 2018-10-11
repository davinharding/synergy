class Message < ApplicationRecord
  belongs_to :sender, class_name: "Profile"
  belongs_to :recipient, class_name: "Profile"

  after_create_commit :broadcast_message

  scope :between, ->  (profile_1, profile_2) do
                        where(
                          "(sender_id = :profile_1_id AND recipient_id = :profile_2_id) OR
                          (sender_id = :profile_2_id AND recipient_id = :profile_1_id)",
                          profile_1_id: profile_1.id,
                          profile_2_id: profile_2.id
                        )
                      end

  private

  def action_cable_channel
    "messages:#{[sender_id, recipient_id].sort.join(':')}"
  end

  def broadcast_message
    ActionCable.server.broadcast(action_cable_channel, {})
  end

end
