require 'rails_helper'
include Devise::TestHelpers

RSpec.describe RecipesController, :type => :controller do

  before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  it "should render the correct recipe page" do
    r = Recipe.create(id: 1, :name => 'Soup')
    get :show, id: r.id
    expect(response).to render_template("recipes/show")
  end
end
