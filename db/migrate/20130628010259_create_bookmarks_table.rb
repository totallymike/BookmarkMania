class CreateBookmarksTable < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :tags # This won't be a string forever.  For now it's fine.
    end
  end
end
