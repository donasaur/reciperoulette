class RecipesController < ApplicationController

  def create
  end

  def show
    @recipe = Recipe.find(params[:id])
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
