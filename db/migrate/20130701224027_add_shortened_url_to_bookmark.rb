class AddShortenedUrlToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :shortened_url, :string
  end
end
