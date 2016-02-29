require 'rails_helper'

feature "Commenting" do

  let(:user){ create(:user_with_posts) }

  before do
    sign_in(user)
    visit user_posts_path(user_id: user.id)
  end

  scenario "allows commenting on posts" do
    fill_in "comment_content", with: "Moar bacon"
    click_button "Comment"
    expect(page).to have_content("Comment successfully saved!")
  end

  scenario "does not save empty post comments" do
    click_button "Comment"
    expect(page).not_to have_content("Comment successfully saved!")
  end
end