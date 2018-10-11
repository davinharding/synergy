class AddSkillToUserActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :user_activities, :skill_level, :string
  end
end
