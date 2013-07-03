require 'spec_helper'

feature 'The index of sites lists the titles of all sites' do
  scenario 'A user views the list of sites' do
    create(:bookmark)
    create(:bookmark, url: 'http://www.reddit.com/r/ruby')
    visit(sites_path)

    expect(page).to have_link('Example!')
    expect(page).to have_link('reddit: the front page of the internet')
  end
end