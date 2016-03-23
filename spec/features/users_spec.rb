require 'rails_helper'

feature "User management" do

  before{ visit root_path }

  scenario "allows sign up, goes to profile page, and sends email" do
    fill_in "First name", with: "Foo"
    fill_in "Last name", with: "Bar"
    fill_in "user_email", with: "foo@bar.com"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "First name", with: "Foo"
    select "1980", from: "user_profile_attributes_dob_1i"
    select "January", from: "user_profile_attributes_dob_2i"
    select "12", from: "user_profile_attributes_dob_3i"
    choose "Female"

    click_button "Sign up!"

    expect(page).to have_content "You successfully signed up!"

    # TODO: how to check this when I don't have the id?
    # expect(current_path).to eq(profile_path)

    expect(page).to have_content "About Foo Bar"
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  scenario "does not allow sign up with no info" do
    click_button "Sign up!"
    expect(page).to have_content "We could not sign you up. See errors below."
  end

  scenario "allows profile editing" do
    user = create(:user_with_profile)
    sign_in(user)

    visit profile_path(user.profile.id)
    click_link "Edit Your Profile"

    fill_in "College", with: "Foo University"
    fill_in "Hometown", with: "Foo, TX"
    fill_in "Currently Lives", with: "Bar, LA"
    fill_in "Phone", with: "504-555-1234"
    fill_in "Phone", with: "504-555-1234"
    fill_in "profile_words_to_live_by", with: "Lorem ipsum"
    fill_in "profile_about", with: "Bacon ipsum"

    click_button "Save Changes"

    expect(page).to have_content("Profile successfully updated!")
  end

end

