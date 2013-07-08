class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  validates :name, uniqueness: true

  def self.with_bookmarks
    joins{bookmarks.inner}
  end

  def self.with_bookmarks_for_user(user)
    with_bookmarks.where{bookmarks.user_id.eq user_id}
  end

  def bookmarks_from_user(user)
    bookmarks.where{user_id.eq user.id}
  end

  def to_s
    self.name
  end
end
