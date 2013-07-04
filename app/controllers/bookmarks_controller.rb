class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
  end

  def show
    @bookmark = current_user.bookmarks.find_by(id: params[:id])
    if @bookmark.nil?
      redirect_to bookmarks_path
    else
      @short_url = build_short_url(@bookmark)
    end
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      current_user.bookmarks << @bookmark
      current_user.sites << @bookmark.site
      current_user.tags  << @bookmark.tags
      redirect_to @bookmark
    else
      flash[:error] = 'URL required'
      redirect_to root_url
    end
  end

  def short_url
    @bookmark = Bookmark.find_by(shortened_url: params[:short_url])
    redirect_to @bookmark.url, status: 301
  end

  private
  def build_short_url(bookmark)
      request.protocol <<
        request.raw_host_with_port <<
        short_url_path(bookmark.shortened_url)
  end
  def bookmark_params
    params.require(:bookmark).permit(:url, :tags_list)
  end
end
