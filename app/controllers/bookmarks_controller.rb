class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
    @short_url = build_short_url(@bookmark)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
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