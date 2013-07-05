module LoginMacros
  def log_in(user = nil)
    user ||= create(:user)

    visit root_path

    click_link 'Sign in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'

    user
  end
end
