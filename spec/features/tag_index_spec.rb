require 'spec_helper'

feature 'The index of sites lists the titles of all sites' do
  scenario 'A user views the list of sites' do
    create(:bookmark_with_tags)
    visit(tags_path)

    expect(page).to have_link('Tag1')
    expect(page).to have_link('Tag2')
  end
end