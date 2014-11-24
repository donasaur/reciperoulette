require 'rails_helper'
include Devise::TestHelpers

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, :type => :helper do

  before(:each) do
    @user = User.new(email: "test@helper.com", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
    @pantry = @user.pantry
    @a = Ingredient.create({name: 'a'})
    @b = Ingredient.create({name: 'b'})
    @c = Ingredient.create({name: 'c'})
    @d = Ingredient.create({name: 'd'})
    @pantry.ingredients << @a
    @pantry.ingredients << @b
    @pantry.ingredients << @c
    @pantry.ingredients << @d
  end

  describe "get active ingredients" do

    it "should default to all ingredients active if none are selected" do
      active_ingredients = get_active_ingredients(@user)
      expect(active_ingredients).to include(@a)
      expect(active_ingredients).to include(@b)
      expect(active_ingredients).to include(@c)
      expect(active_ingredients).to include(@d)
    end

    it "should only include active ingredients if some are activated" do
      p_i = PantryIngredient.find_by(pantry_id: @pantry.id, ingredient_id: @a.id)
      p_i.active = true;
      p_i.save
      active_ingredients = get_active_ingredients(@user)
      expect(active_ingredients).to include(@a)
      expect(active_ingredients).not_to include(@b)
      expect(active_ingredients).not_to include(@c)
      expect(active_ingredients).not_to include(@d)  
    end

    it "should be empty if user has no ingredients" do
      @pantry.ingredients.delete(@a)
      @pantry.ingredients.delete(@b)
      @pantry.ingredients.delete(@c)
      @pantry.ingredients.delete(@d)
      active_ingredients = get_active_ingredients(@user)
      expect(active_ingredients).to be_empty
    end
  end

  describe "progress bar percentage" do
    before(:each) do
      @red = "rgba(255,0,0,0.7)"
      @orange = "rgba(255,165,0,0.7)"
      @yellow = "rgba(255,255,0,0.7)"
      @green = "rgba(0,100,0,0.7)"
      @r1 = Recipe.create({name: 'r1', ingredients: [@a, @b]})
      @r2 = Recipe.create({name: 'r2', ingredients: [@b, @c]})
      @r3 = Recipe.create({name: 'r3', ingredients: [@b, @c, @d]})
      @r4 = Recipe.create({name: 'r4', ingredients: [@a, @b, @c, @d]})
    end

    it "should return red rgba if only 1/4 ingredients match" do
      p_i = PantryIngredient.find_by(pantry_id: @pantry.id, ingredient_id: @a.id)
      p_i.active = true;
      p_i.save
      bar = progress_bar_percentage(@r4, @user)
      expect(bar).to eq('#FF6600')    
    end

    it "should return orange rgba if 1/2 ingredients match" do
      p_i = PantryIngredient.find_by(pantry_id: @pantry.id, ingredient_id: @a.id)
      p_i.active = true;
      p_i.save
      bar = progress_bar_percentage(@r1, @user)
      expect(bar).to eq('#FFCC00')    
    end

    it "should return yellow rgba if 2/3 ingredients match" do
      p_i = PantryIngredient.find_by(pantry_id: @pantry.id, ingredient_id: @b.id)
      p_i.active = true;
      p_i.save
      p_i = PantryIngredient.find_by(pantry_id: @pantry.id, ingredient_id: @c.id)
      p_i.active = true;
      p_i.save
      bar = progress_bar_percentage(@r3, @user)
      expect(bar).to eq('#CCFF00')         
    end

    it "should return green if all ingredients match" do
      bar = progress_bar_percentage(@r4, @user)
      expect(bar).to eq('#339900')
    end
  end





end
