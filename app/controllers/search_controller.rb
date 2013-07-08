class SearchController < ApplicationController
  def new
    search_string = "%#{params[:search]}%"
    @bookmarks = Bookmark.where {
      url.matches(search_string) | title.matches(search_string)
    }
  end
end