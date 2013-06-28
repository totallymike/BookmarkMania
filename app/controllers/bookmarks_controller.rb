class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url, :tags_list)
  end
end