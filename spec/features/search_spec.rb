require 'spec_helper'

feature 'Bookmark search ' do
  scenario 'A user searches his bookmarks' do
    log_in

    bookmark = add_bookmark('http://www.reddit.com/r/ruby')

    visit root_path
    fill_in 'search', with: 'reddit'
    click_button 'Search'

    within '#bookmarks' do
      expect(page).to have_text bookmark.url
      expect(page).to have_text bookmark.title
    end
  end
end