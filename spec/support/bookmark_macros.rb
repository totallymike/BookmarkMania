module BookmarkMacros
  def add_bookmark(url, tags_list = nil)
    visit root_path
    fill_in 'bookmark_url', with: url
    fill_in 'bookmark_tags_list', with: tags_list if tags_list
    click_button 'Save'
  end
end