class PantriesController < ApplicationController
  def update
    @user = current_user
    @pantry = @user.pantry
    if params["commit"] == "Add Ingredient"
      added_ingredient = params["ingredient"].to_i
      @pantry.ingredient_ids = @pantry.ingredient_ids << added_ingredient
    elsif params["commit"] == "Delete Ingredients"
      ingredient_ids = params["pantry"]["ingredient_ids"].map(&:to_i)
      @pantry.ingredient_ids = @pantry.ingredient_ids - ingredient_ids
      @pantry.save
    end
    @ingredients = @pantry.ingredients
    redirect_to users_dashboard_url
  end

  def sort
    params[:ingredient].each_with_index do |id, index|
      i = Ingredient.find(id).pantry_ingredients[0]
      i.position = index + 1
      i.save
    end
    render nothing: true
  end
end
