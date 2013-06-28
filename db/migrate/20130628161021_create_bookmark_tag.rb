class CreateBookmarkTag < ActiveRecord::Migration
  def change
    create_table :bookmarks_tags do |t|
      t.references :tag, index: true
      t.references :bookmark, index: true
    end
  end
end
