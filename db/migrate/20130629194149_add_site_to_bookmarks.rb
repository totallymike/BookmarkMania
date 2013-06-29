class AddSiteToBookmarks < ActiveRecord::Migration
  def change
    add_reference :bookmarks, :site, index: true
  end
end
