require 'spec_helper'

feature 'The index of sites lists the titles of all sites' do
  scenario 'A user views the list of tags' do
    create(:bookmark_with_tags)
    visit(tags_path)

    expect(page).to have_link('Tag1')
    expect(page).to have_link('Tag2')
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