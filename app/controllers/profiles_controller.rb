class ProfilesController < ApplicationController
  skip_before_action :send_user_to_create_profile_unless_profile_exists, only: [:new, :create]

  #Chose one line below based on Geo filter or no geo filter

  def index
    @current_user_activities = current_user.activities
    # @profiles = Profile.where(activities: @current_user_activities)
    @profiles = Profile.all.near([current_user.profile.latitude, current_user.profile.longitude], 1)
    @activities = Activity.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
    @activities = Activity.all
    @user_activities = current_user.activities
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.save
    params[:profile][:activity][:activity].each do |activity, attributes|
      if attributes[:checked] == "true"
        user_activity = UserActivity.find_or_create_by(
                          user: current_user,
                          activity: Activity.find_by_activity(activity)
                        )
        user_activity.skill_level = attributes[:skill_level]
        user_activity.save
      else
        UserActivity.where(
          user: current_user,
          activity: Activity.find_by_activity(activity)
        ).delete_all
      end
    end
    redirect_to profiles_path
  end

  def edit
    @profile = current_user.profile
    @activities = Activity.all
    @user_activities = current_user.activities
    # redirect_to profiles_path
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    params[:profile][:activity][:activity].each do |activity, attributes|
      if attributes[:checked] == "true"
        user_activity = UserActivity.find_or_create_by(
                          user: current_user,
                          activity: Activity.find_by_activity(activity)
                        )
        user_activity.skill_level = attributes[:skill_level]
        user_activity.save
      else
        UserActivity.where(
          user: current_user,
          activity: Activity.find_by_activity(activity)
        ).delete_all
      end
    end
    redirect_to profiles_path
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :age, :location, :picture, :activity, :gender, :bio, :user_id, :image, :city, :state, :street, :country)
  end

end
