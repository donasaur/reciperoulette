class PantriesController < ApplicationController
  def update
    @user = current_user
    @pantry = @user.pantry
    if params["commit"] == "Add Ingredient"
      added_ingredient = Ingredient.find_by_name(params[:ingredient_name])
      if !@pantry.ingredients.exists?(added_ingredient)
        @pantry.ingredients << added_ingredient
        @pantry.save
      end
      redirect_to users_dashboard_path

    elsif params["commit"] == "Delete Ingredient"
      deleted_ingredient = Ingredient.find(params["ingredient"].to_i)
      @pantry.ingredients.delete(deleted_ingredient)
      @pantry.save
      redirect_to users_dashboard_path

    elsif params["commit"] == "Play Roulette"
      ingredient_ids = params["pantry"]["ingredient_ids"].map(&:to_i)
      @pantry.ingredients.each do |ingredient|
        pantry_ingredient = @pantry.pantry_ingredients.find_by(ingredient_id: ingredient.id)
        present = ingredient_ids.include?(ingredient.id)
        pantry_ingredient.active = present
        pantry_ingredient.save
      end
      redirect_to users_roulette_path
    end
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
