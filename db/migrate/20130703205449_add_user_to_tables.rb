class AddUserToTables < ActiveRecord::Migration
  def change
    add_reference :bookmarks, :user, index: true
    add_reference :tags, :user, index: true
    add_reference :sites, :user, index: true
  end
end
