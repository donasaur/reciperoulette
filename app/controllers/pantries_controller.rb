class PantriesController < ApplicationController
  def update
    @user = current_user
    @pantry = @user.pantry
    if params["commit"] == "Add Ingredient"
      added_ingredient = Ingredient.find(params["ingredient"].to_i)
      if !@pantry.ingredients.exists?(added_ingredient)
        @pantry.ingredients << added_ingredient
        @pantry.save
      end
    elsif params["commit"] == "Delete Ingredient"
      deleted_ingredient = Ingredient.find(params["ingredient"].to_i)
      @pantry.ingredients.delete(deleted_ingredient)
      @pantry.save
    end
    redirect_to users_dashboard_path
  end
end
