require 'rails_helper'

RSpec.describe RecipesController, :type => :controller do

  before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
  end

  it "should render the correct recipe page" do
    r = Recipe.create(id: 1, :name => 'Soup', instructions: 'a', prep_time:1, cook_time:1)
    get :show, id: r.id
    expect(response).to render_template("recipes/show")
  end
end
