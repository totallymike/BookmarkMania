require 'spec_helper'

feature 'The index of sites lists the titles of all sites' do
  scenario 'A user views the list of sites' do
    user = log_in

    add_bookmark('http://example.com/page1')
    add_bookmark('http://www.reddit.com/r/ruby')

    visit(sites_path)

    expect(page).to have_link('Example!')
    expect(page).to have_link('reddit: the front page of the internet')
  end
end
