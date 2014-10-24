require 'rails_helper'
include Devise::TestHelpers

RSpec.describe RecipesController, :type => :controller do

  it "should render the correct recipe page" do
    @recipe = Recipe.create(:name => 'Soup')
    get :show, { :name => @recipe.name }
    expect(response).to render_template("recipes/recipe")
  end
end
