require 'rails_helper'

feature "Liking" do

  let(:user){ create(:user_with_posts) }

  before do
    sign_in(user)
    visit user_posts_path(user_id: user.id)
  end

  scenario "allows liking of posts" do
    within(".post-footer") do
      click_link "Like", match: :first
    end
    expect(page).to have_content("Post liked!")
  end

  scenario "allows liking of comments" do
    within("article.comment") do
      click_link "Like"
    end
    expect(page).to have_content("Comment liked!")
  end

  scenario "allows unliking of posts" do
    within(".post-footer"){ click_link "Like", match: :first}
    within(".post-footer"){ click_link "Unlike" }
    expect(page).to have_content("Like removed!")
  end

  scenario "allows unliking of comments" do
    within("article.comment"){ click_link "Like", match: :first}
    within("article.comment"){ click_link "Unlike" }
    expect(page).to have_content("Like removed!")
  end
end
