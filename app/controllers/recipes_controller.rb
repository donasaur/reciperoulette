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

end
