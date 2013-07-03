require 'spec_helper'

feature 'Tags link back to bookmarks' do
  scenario 'A user views a tag' do
    bookmark1 = create(:bookmark, url: 'http://example.com/page1', tags_list: 'Example1, Example2')
    bookmark2 = create(:bookmark, url: 'http://example.com/page2', tags_list: 'Example1')
    tag = Tag.find_by(name: 'Example1')

    visit(tag_path(tag))
    expect(page).to have_link(bookmark1.title)
    expect(page).to have_link(bookmark2.title)
  end
end