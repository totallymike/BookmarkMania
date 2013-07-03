class Site < ActiveRecord::Base
  before_create :assign_page_attributes
  has_many :bookmarks

  private
  def assign_page_attributes
    PageIdentifier.new(self).assign_attributes!
  end
end
