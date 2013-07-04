class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @bookmark = Bookmark.new
  end
end
