class Bookmark < ActiveRecord::Base
  before_create :find_or_create_site

  belongs_to :site
  has_and_belongs_to_many :tags

  validates :url, presence: true

  def tags_list
    self.tags.join(' ')
  end

  def tags_list=(tags_string)
    tag_names = tags_string.split(', ')
    self.tags = tag_names.map{|tag| Tag.find_or_create_by(name: tag)}
  end

  def find_or_create_site()
    domain = extract_domain(self.url)
    self.site = Site.find_or_create_by(domain: domain)
  end

  private
  def extract_domain(url)
    URI(url).host
  end
end