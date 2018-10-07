class ProfilesController < ApplicationController
  skip_before_action :send_user_to_create_profile_unless_profile_exists, only: [:new, :create]

  def index
    @profiles = Profile.all
  end

  def new 
    @profile = Profile.new
    @activities = Activity.all 
    @user_activities = current_user.activities
  end 

  def create 
    @profile = Profile.new(profile_params)
    @profile.save
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
    

    Activity.all.each do |activity|
      id = activity.id.to_s
      if params&.dig(:activity)&.include?(id) && !current_user.activities.include?(activity) 
        current_user.activities << Activity.find(id)
      elsif current_user.activities.include?(activity) && !params&.dig(:activity)&.include?(id)
        current_user.activities.delete(activity)
      end
    end

    redirect_to profiles_path
  end 

  private 

  def profile_params
    params.require(:profile).permit(:name, :age, :location, :picture, :activity, :gender, :bio, :user_id, :image)
  end

end
