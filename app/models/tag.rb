class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  validates :name, uniqueness: true

  def self.with_bookmarks
    includes(:bookmarks).where.not('bookmarks.id' => nil).references(:bookmarks)
  end

  def bookmarks_from_user(user)
    bookmarks.where(user: user)
  end

  def to_s
    self.name
  end
end
