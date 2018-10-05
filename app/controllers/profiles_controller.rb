class ProfilesController < ApplicationController
  skip_before_action :send_user_to_create_profile_unless_profile_exists, only: [:new, :create]

  def index
    @profiles = Profile.all
  end

  def new 
    @profile = Profile.new
    @activities = Activity.all 
  end 

  def create 
    @profile = Profile.new(profile_params)
    @profile.save
    redirect_to profiles_path
  end 

  def edit 
    @profile = current_user.profile
    @activities = Activity.all 
  end

  def update 
  end 

  private 

  def profile_params
    params.require(:profile).permit(:name, :age, :location, :picture, :gender, :bio, :activity, :user_id)
  end

end
