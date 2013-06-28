class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def tags_list=(tags_string)
    tag_names = tags_string.split(', ')
    self.tags = tag_names.map{|tag| Tag.find_or_create_by(name: tag)}
  end
end