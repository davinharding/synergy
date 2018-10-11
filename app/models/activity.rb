class Activity < ApplicationRecord
  has_many :user_activities
  has_many :users, through: :user_activities

  def skill_level_for(user)
    UserActivity.find_by(activity: self, user: user)&.skill_level
  end
end
