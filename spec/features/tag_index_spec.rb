require 'spec_helper'

feature 'The index of tags lists the names of all tags' do
  scenario 'A user views the list of tags' do
    user = create(:user)
    visit root_path
    click_link 'Log in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'

    visit root_path
    fill_in 'bookmark_url', with: 'http://example.com/page1'
    fill_in 'bookmark_tags_list', with: 'Tag1, Tag2'
    click_button 'Save'

    visit(tags_path)

    expect(page).to have_link('Tag1')
    expect(page).to have_link('Tag2')
  end

  scenario "The tags index does not display tags a user doesn't use" do
    user = create(:user)
    unattached_bookmark = create(:bookmark,
      url: 'http://example.com/page2',
      tags_list: 'Tag2')

    visit root_path
    click_link 'Log in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'

    visit root_path
    fill_in 'bookmark_url', with: 'http://example.com/page1'
    fill_in 'bookmark_tags_list', with: 'Tag1, Tag2'
    click_button 'Save'

    visit tags_path

    expect(page).to have_link('Tag1')
    expect(page).to_not have_link('Tag2')
  end

  scenario "The tags index does not display tags with no bookmarks" do
    create(:bookmark, tags_list: 'Tag1, Tag2')
    dead_guy = create(:bookmark, url: 'http://example.com/page2', tags_list: 'Tag3')

    dead_guy.delete

    visit(tags_path)
    expect(page).to have_link('Tag1')
    expect(page).to have_link('Tag2')
    expect(page).to_not have_link('Tag3')
  end
end