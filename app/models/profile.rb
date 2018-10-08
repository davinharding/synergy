class Profile < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :name, presence: true
  geocoded_by :address
  after_validation :geocode

  def address
    [street, city, state, country].compact.join(', ')
  end
end
