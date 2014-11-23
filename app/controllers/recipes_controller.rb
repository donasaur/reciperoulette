class RecipesController < ApplicationController

  def create
  end

  def show
    @recipe = Recipe.find(params[:id])
    @rating = Rating.where(recipe_id: @recipe.id, user_id: current_user.id).first
    if @rating.nil?
      @rating = Rating.create(recipe_id: @recipe.id, user_id: current_user.id, score: 0)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
  end

  def delete_recipe
    recipe_id = params[:recipe_id].to_i
    user = current_user
    deleted_recipe = Recipe.find(recipe_id)
    user.recipes.delete(deleted_recipe)
    user.save
    redirect_to users_dashboard_path
  end

end
