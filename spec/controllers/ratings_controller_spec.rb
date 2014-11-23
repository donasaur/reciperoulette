require 'rails_helper'
include Devise::TestHelpers
include RecipesHelper

RSpec.describe RatingsController, :type => :controller do
  before :all do
    Rating.destroy_all
    @user = User.create(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @pantry = @user.pantry
    create_sample_recipe
  end

  it "should make sure that sending a PATCH request to /ratings/:id registers a rating", :type => 'special' do
    # Create a pseudo-rating
    recipe_of_interest = Recipe.all.first
    rating = Rating.create(recipe_id: recipe_of_interest.id, user_id: @user.id, score: 0)

    patch :update, { :id => rating.id, :score => 4, :testing_mode => true }
    expect(assigns[:rating].score).to eq(4)
    expect(recipe_of_interest.average_rating).to eq(4) # Only one rating, so average should be four
  end

  it "should make sure that average rating works correctly", :type => 'special' do
    recipe_of_interest = Recipe.all.first
    rating = Rating.create(recipe_id: recipe_of_interest.id, user_id: @user.id, score: 4)
    @user2 = User.create(email: "clinton@whitehouse.gov", password: 'password', password_confirmation: 'password')
    rating2 = Rating.create(recipe_id: recipe_of_interest.id, user_id: @user2.id, score: 0)
    expect(recipe_of_interest.average_rating).to eq(2) # Two ratings now, so average should be two
  end


end