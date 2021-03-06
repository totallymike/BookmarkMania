require 'spec_helper'

feature 'A site should list the bookmarks associated with it' do
  scenario 'A user views a site' do
    log_in
    bookmark1 = add_bookmark('http://example.com/page1')
    bookmark2 = add_bookmark('http://example.com/page2')

    visit(site_path(bookmark1.site))
    expect(page).to have_link(bookmark1.title)
    expect(page).to have_link(bookmark2.title)
  end
end
