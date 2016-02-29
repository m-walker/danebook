require 'rails_helper'

feature "Posting" do

  let(:user){ create(:user_with_profile) }

  before do
    sign_in(user)
    visit user_posts_path(user_id: user.id)
  end

  scenario "allows posting on own page" do
    fill_in "post_content", with: "Hipster ipsum"
    click_button "Post"
    expect(page).to have_content("Posted!")
  end

  scenario "does not save empty posts" do
    click_button "Post"
    expect(page).not_to have_content("Posted!")
  end
end