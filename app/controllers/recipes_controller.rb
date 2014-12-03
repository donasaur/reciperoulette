class RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    @all_ingredients = Ingredient.all.map(&:name)
  end

  def create
    @recipe = Recipe.new
    @all_ingredients = Ingredient.all.map(&:name)
    if !params[:tags] || params[:tags][:tag_ids].length == 0
      flash.now[:alert] = "Failed to add new recipe - Please select at least one tag."
      render 'new'
      return
    end
    bad_ings = []
    good_ings = []
    if !params[:ingredients]
      flash.now[:alert] = "Failed to add new recipe - Need at least one ingredient."
      render 'new'
      return
    end
    params[:ingredients].each do |ing|
      if !ing.empty?
        if !@all_ingredients.include?(ing)
          bad_ings << ing
        else
          good_ings << Ingredient.find_by(name: ing)
        end
      end
    end
    if !bad_ings.empty?
      flash.now[:alert] = "Failed to add new recipe - Some ingredients are missing from our database: #{bad_ings.join(', ')}. You can add new ingredients on your dashboard."
      render 'new'
      return
    end
    if good_ings.empty?
      flash.now[:alert] = "Failed to add new recipe - Need at least one ingredient."
      render 'new'
      return
    end
    tags = Tag.where(id: params[:tags][:tag_ids].map(&:to_i))
    @recipe = Recipe.new( 
                        { name: params[:name], 
                          prep_time: params[:prep_time],
                          cook_time: params[:cook_time],
                          instructions: params[:instructions],
                          ingredients: good_ings,
                          tags: tags,
                          image: params[:recipe][:image] }
                          )
    if @recipe.save
      current_user.recipes << @recipe
      flash[:notice] = "Successfully saved your new recipe!"
      redirect_to users_dashboard_path
    else
      flash.now[:alert] = "Failed to add new recipe - " + @recipe.errors.full_messages.join('; ')
      render 'new'
    end
    return
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
