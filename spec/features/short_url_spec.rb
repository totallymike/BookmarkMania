require 'spec_helper'

feature 'Short URL redirection' do
  scenario 'A user follows a short URL' do
    bookmark = create(:bookmark)

    visit(short_url_path(bookmark.shortened_url))
    expect(page.driver.browser.last_response.status).to eq 301
  end
end