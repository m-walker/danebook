module LoginMacros

  def sign_in(user)
    visit root_path
    within("nav") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'
    end
  end

  # TODO: remove if not needed
  # def sign_out
  #   visit root_path
  #   click_link 'Logout'
  # end
end