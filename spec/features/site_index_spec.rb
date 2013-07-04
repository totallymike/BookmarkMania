require 'spec_helper'

feature 'The index of sites lists the titles of all sites' do
  scenario 'A user views the list of sites' do
    user = create(:user)

    visit(new_user_session_path)
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'

    visit root_path
    fill_in 'bookmark_url', with: 'http://example.com/page1'
    click_button 'Save'

    visit root_path
    fill_in 'bookmark_url', with: 'http://www.reddit.com/r/ruby'
    click_button 'Save'

    visit(sites_path)

    expect(page).to have_link('Example!')
    expect(page).to have_link('reddit: the front page of the internet')
  end
end
