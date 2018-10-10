class ProfilesController < ApplicationController
  skip_before_action :send_user_to_create_profile_unless_profile_exists, only: [:new, :create]

  #Chose one line below based on Geo filter or no geo filter
  
  def index
    @profiles = Profile.all
    respond_to do |format|
      format.html
      format.json do 
        @profiles = Profile.all
        @activities = Activity.all
        @current_user_activities = current_user.activities
        render json: @profiles
      end 
    end 
    # @profiles = Profile.where(activities: @current_user_activities)
    #@profiles = Profile.all.near([current_user.profile.latitude, current_user.profile.longitude], 1)
    
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
    render json: @profile
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
        current_user.activities.sortgi
      elsif current_user.activities.include?(activity) && !params&.dig(:activity)&.include?(id)
        current_user.activities.delete(activity)
      end
    end

    redirect_to profiles_path
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :age, :location, :picture, :activity, :gender, :bio, :user_id, :image, :city, :state, :street, :country)
  end

end
