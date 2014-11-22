# def login(email, password)
#   visit '/users/sign_in'
#   within("#new_user") do
#     fill_in 'Email', :with => email
#     fill_in 'Password', :with => password
#   end
#   click_button 'Log in'
# end

def visit_edit_page(email, password)
  login_as(@user, :scope => :user, :run_callbacks => false)
  visit '/users/dashboard'
  page.find(".dropdown").click
  click_link("Edit profile")
end

describe "the signin process", :type => :feature do
  before :all do
    @user = User.create!(:email => 'testuser@example.com', :password => 'password', :password_confirmation => 'password')
  end

  after :all do
    @user.destroy!
  end

  it "signs me in" do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit "/"
    expect(page).to have_content 'Welcome to your dashboard'
  end

  it "goes to the edit page from dashboard" do
    visit_edit_page('user@example.com', 'password')
    expect(page).to have_content "Edit User"
  end

  #todo: fix JS support
  it "cancels the user's account", :js => true do
    visit_edit_page('user@example.com', 'password')

    # Click on OK in the JavaScript popup box
    page.accept_alert 'Are you sure?' do
      click_button("Cancel my account")
    end

    expect(page).to have_content "Welcome to Recipe Roulette!"
  end

  it "add one ingredient", :js => true do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit '/users/dashboard'
    fill_in('ingredient_name', :with => 'Milk')
    click_button('Add Ingredient')

    expect(page).to have_content "milk"
    expect(page).to_not have_content "salt"
  end

end
