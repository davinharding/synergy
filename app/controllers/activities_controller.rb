class ActivitiesController < ApplicationController
  def index
    respond_to do |format|
      format.json do 
        @activities = Profile.all
        @activities = @activities.order(id: :asc).map{|profile| profile.activities }
        render json: @activities
      end
    end 
  end
end
