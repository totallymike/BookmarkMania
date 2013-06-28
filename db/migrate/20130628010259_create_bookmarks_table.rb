class CreateBookmarksTable < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url

      t.timestamps
    end
  end
end
