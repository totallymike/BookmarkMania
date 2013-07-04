require 'spec_helper'

feature 'Tags link back to bookmarks' do
  scenario 'A user views a tag' do
    user = log_in

    create(:bookmark, url: 'http://example.com/page2', tags_list: 'Example1')

    visit root_path
    fill_in 'bookmark_url', with: 'http://example.com/page1'
    fill_in 'bookmark_tags_list', with: 'Example1, Example2'
    click_button 'Save'

    visit root_path
    fill_in 'bookmark_url', with: 'http://www.reddit.com/r/ruby'
    fill_in 'bookmark_tags_list', with: 'Example1'
    click_button 'Save'

    tag = user.tags.find_by(name: 'Example1')
    visit(tag_path(tag))

    expect(page).to have_link('Example Page Number 1!')
    expect(page).to have_link('reddit: the front page of the internet')
    expect(page).to_not have_link('Example Page Number 2!')
  end
end