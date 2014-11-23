class RatingsController < ApplicationController

  def update
    @rating = Rating.find(params[:id])
    @recipe = @rating.recipe
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