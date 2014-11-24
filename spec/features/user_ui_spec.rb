
def visit_edit_page(email, password)
  login_as(@user, :scope => :user, :run_callbacks => false)
  visit '/users/dashboard'
  page.find(".dropdown").click
  click_link("User Settings")
end

describe "the signin process", :type => :feature do
  before :all do
    User.destroy_all
    @user = User.create!(:email => 'testuser@example.com', :password => 'password', :password_confirmation => 'password')
    create_sample_recipe
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

  it "sees an error message with wrong login information", type: "in_progress" do
    visit "/users/sign_in"
    fill_in('email', :with => 'Not@Right.com')
    fill_in('password', :with => 'Wrong')
    click_button('Log in')
    expect(page).to have_content "Invalid"
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

end
