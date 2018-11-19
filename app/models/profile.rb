class Profile < ApplicationRecord
  belongs_to :user
  has_many :activities, through: :user
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"
  has_one_attached :image
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :notifications, foreign_key: :recipient_id

  validates :name, presence: true
  geocoded_by :address
  after_validation :geocode

  scope :min_age,     ->  (age) { where("age >= ?", age ) }
  scope :max_age,     ->  (age) { where("age <= ?", age) }
  scope :by_gender,   ->  (gender) { where(gender: gender) }
  scope :by_activity, ->  (activities) do
                            joins(user: :activities)
                              .where(activities: { activity: activities })
                          end

  def address
    [street, city, state, country].compact.join(', ')
  end

  def image_url
    app.rails_blob_url(self.image) if self.image.attached?
  end
end
