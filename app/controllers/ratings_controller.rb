class RatingsController < ApplicationController

  def update
    @rating = Rating.find_by_id params[:id]
    @recipe_id = params[:recipe_id]
    if @rating.nil? || params[:id] == -1
      @rating = Rating.create(recipe_id: @recipe_id, user_id: current_user.id, score: 0)
    end
    if @rating.update_attributes(score: params[:score])
      if params[:testing_mode] # practicing use of test hook!
        render :nothing => true
      else
        respond_to do |format|
          format.js
        end
      end
    end
  end

end