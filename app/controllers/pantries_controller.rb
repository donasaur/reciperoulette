class PantriesController < ApplicationController
  def update
    @user = current_user
    @pantry = @user.pantry
    if params["commit"] == "Add Ingredient"
      ingredient_name = params[:ingredient_name].downcase
      added_ingredient = Ingredient.find_by_name(ingredient_name.singularize) ||  Ingredient.find_by_name(ingredient_name.pluralize)
      if added_ingredient && @pantry.ingredients.include?(added_ingredient)
        flash[:notice] = "#{ingredient_name} is already in your pantry"
        redirect_to users_dashboard_path
      elsif added_ingredient
        @pantry.ingredients << added_ingredient
        @pantry.save
        redirect_to users_dashboard_path
      else
        flash[:ingredienterror] = "You tried to add #{ingredient_name}, an ingredient not in our database. If you would like to add this ingredient, press add. Else press no"
        redirect_to users_dashboard_path(ingredient_name: ingredient_name)
      end
    elsif params["commit"] == "Delete Ingredient"
      deleted_ingredient = Ingredient.find(params["ingredient"].to_i)
      @pantry.ingredients.delete(deleted_ingredient)
      @pantry.save
      redirect_to users_dashboard_path

    elsif params["commit"] == "Add New Ingredient"
      ingredient_name = params[:ingredient_name].downcase
      i = Ingredient.create(name: ingredient_name)
      flash[:notice] = "Ingredient #{ingredient_name} was created!"
      @pantry.ingredients << i
      @pantry.save
      redirect_to users_dashboard_path
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
