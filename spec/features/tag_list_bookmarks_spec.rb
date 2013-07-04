require 'spec_helper'

feature 'Tags link back to bookmarks' do
  scenario 'A user views a tag' do
    user = log_in

    create(:bookmark, url: 'http://example.com/page2', tags_list: 'Example1')

    add_bookmark('http://example.com/page1', 'Example1, Example2')
    add_bookmark('http://www.reddit.com/r/ruby', 'Example1')

    tag = Tag.find_by(name: 'Example1')
    visit(tag_path(tag))

    expect(page).to have_link('Example Page Number 1!')
    expect(page).to have_link('reddit: the front page of the internet')
    expect(page).to_not have_link('Example Page Number 2!')
  end
end