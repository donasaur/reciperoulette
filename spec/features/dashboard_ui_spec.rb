describe "the signin process", :type => :feature do
  before :all do
    User.destroy_all
    @user = User.create!(:email => 'testuser@example.com', :password => 'password', :password_confirmation => 'password')
    create_sample_recipe
  end

  it "add one ingredient", :js => true do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit '/users/dashboard'
    fill_in('ingredient_name', :with => 'Milk')
    click_button('Add Ingredient')

    expect(page).to have_content "milk"
    expect(page).to_not have_content "salt"
  end

  it "adds an ingredient that doesn't exist", :js => true, type: "in_progress" do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit '/users/dashboard'
    fill_in('ingredient_name', :with => 'random')
    click_button('Add Ingredient')
    click_button('Add')
    expect(page).to have_content "random"
  end

end
