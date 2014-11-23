include RecipesHelper

# Visits the first recipe
def visit_recipe_page(email, password)
  login_as(@user, :scope => :user, :run_callbacks => false)
  visit '/recipes/1'
end

describe "the signin process", :type => :feature do
  before :all do
    User.destroy_all
    @user = User.create!(:email => 'testuser@example.com', :password => 'password', :password_confirmation => 'password')
    create_sample_recipe
  end

  # Use dev tools inspect elements and get the xpath of an element
  # Make sure to convert all quotes " in the xpath to \"
  it "checks that ratings are working as intended", :js => true do
    visit_recipe_page('user@example.com', 'password')
    page.find(:xpath, "//*[@id=\"user_star\"]/img[4]").click
    
    good_star_selected = page.find(:xpath, "//*[@id=\"user_star\"]/img[4]")["src"].include? "star-on.png"
    expect(good_star_selected).to be(true)
  end

end