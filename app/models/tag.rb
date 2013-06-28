class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  def to_s
    self.name
  end
end
