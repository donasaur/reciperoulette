class PantriesController < ApplicationController
  def update
    @user = current_user
    @pantry = @user.pantry
    if params["commit"] == "Add Ingredient"
      added_ingredient = params["ingredient"].to_i
      @pantry.ingredient_ids = @pantry.ingredient_ids << added_ingredient
      render "user/dashboard"
    elsif params["commit"] == "Delete Ingredients"
      ingredient_ids = params["pantry"]["ingredient_ids"].map(&:to_i)
      @pantry.ingredient_ids = @pantry.ingredient_ids - ingredient_ids
      @pantry.save
      render "user/dashboard"
    end
  end
end
