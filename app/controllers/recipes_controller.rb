class RecipesController < ApplicationController

  def new
  end

  def create
  end

  def show
    @recipe = Recipe.find(params[:id])
    render 'recipe'
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
