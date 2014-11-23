require 'rails_helper'
include Devise::TestHelpers

RSpec.describe RecipesController, :type => :controller do

  it "should render the correct recipe page" do
    @recipe = Recipe.create(:name => 'Soup')
    get :show, id: @recipe.id
    expect(response).to render_template("recipes/show")
  end
end
