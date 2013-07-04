require 'spec_helper'

feature 'The index of tags lists the names of all tags' do
  before(:each) { @user = log_in }

  scenario 'A user views the list of tags' do
    add_bookmark('http://example.com/page1', 'Tag1, Tag2')

    visit(tags_path)

    expect(page).to have_link('Tag1')
    expect(page).to have_link('Tag2')
  end

  scenario "The tags index does not display tags a user doesn't use" do
    unattached_bookmark = create(:bookmark,
      url: 'http://example.com/page2',
      tags_list: 'Tag2')

    add_bookmark('http://example.com/page1', 'Tag1')

    visit tags_path

    expect(page).to have_link('Tag1')
    expect(page).to_not have_link('Tag2')
  end

  scenario "The tags index does not display tags with no bookmarks" do
    add_bookmark('http://example.com/page1', 'Tag1, Tag2')
    add_bookmark('http://example.com/page2', 'Tag3')

    dead_guy = @user.bookmarks.find_by(url: 'http://example.com/page2')
    dead_guy.delete

    visit(tags_path)
    expect(page).to have_link('Tag1')
    expect(page).to have_link('Tag2')
    expect(page).to_not have_link('Tag3')
  end
end