class Message < ApplicationRecord
  belongs_to :sender, class_name: "Profile"
  belongs_to :recipient, class_name: "Profile"

  scope :between, ->  (profile_1, profile_2) do
                        where(
                          "(sender_id = :profile_1_id AND recipient_id = :profile_2_id) OR
                          (sender_id = :profile_2_id AND recipient_id = :profile_1_id)",
                          profile_1_id: profile_1.id,
                          profile_2_id: profile_2.id
                        )
                      end
end
