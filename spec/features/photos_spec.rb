require 'rails_helper'

feature "Photos" do
  let(:user){ create(:user_with_profile) }

  before do
    sign_in(user)
    visit user_photos_path(user_id: user.id)
  end

  scenario "allows uploading of a photo" do
    attach_file('photo[photo]', Rails.root.join('spec', 'support', 'test.jpg'))
    click_button 'Upload'

    expect(page).to have_content('Photo successfully added')
    expect(page.current_path).to eq(user_photos_path(user))
    expect(user.photos.count).to eq(1)
  end

  # TODO: do this
  scenario "fails gracefully with wrong file type"
end