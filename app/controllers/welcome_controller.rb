class WelcomeController < ApplicationController
  def index
    @bookmark = Bookmark.new
  end
end
