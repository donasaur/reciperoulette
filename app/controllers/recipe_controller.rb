class RecipeController < ApplicationController

  def new
  end

  def create
  end

  def show
    @recipe = Recipe.where(name: params[:name]).first
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
