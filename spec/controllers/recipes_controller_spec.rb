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

  it "should not accept recipe without tags" do
    post :create, {name: 'Will fail before it matters'}
    expect(response).to render_template("recipes/new")
    expect(flash[:alert]).to eq "Failed to add new recipe - Please select at least one tag."
  end

  it "should not accept recipes without ingredients" do
    post :create, {tags: { tag_ids: [1, 2, 3] }}
    expect(response).to render_template("recipes/new")
    expect(flash[:alert]).to eq "Failed to add new recipe - Need at least one ingredient."
  end

  it "should not accept ingredients missing in the database" do
    post :create, {tags: { tag_ids: [1, 2, 3] }, ingredients: ['fake', '', '']}
    expect(response).to render_template("recipes/new")
    expect(flash[:alert]).to eq "Failed to add new recipe - Some ingredients are missing from our database: fake. You can add new ingredients on your dashboard."
  end

  it "should fail if only empty ingredients are submitted" do
    post :create, {tags: { tag_ids: [1, 2, 3] }, ingredients: ['', '', '']}
    expect(response).to render_template("recipes/new")
    expect(flash[:alert]).to eq "Failed to add new recipe - Need at least one ingredient."
  end

end
