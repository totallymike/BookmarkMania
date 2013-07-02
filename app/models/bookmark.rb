class Bookmark < ActiveRecord::Base
  before_create :find_canonical_url
  before_create :generate_shortened_url
  before_create :find_or_create_site
  before_create :fetch_page_metadata

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

  private
  def find_canonical_url
    self.url = formulate_url(self.url)
    res = HTTParty.head(self.url, follow_redirects: false)
    self.url = if res.code == 301
      res = HTTParty.head(res.headers['location'],
        maintain_method_across_redirects: true)
      res.request.last_uri.to_s
    else
      url
    end
  end

  def formulate_url(url)
    uri = URI.parse(url)
    if uri.scheme.nil?
      'http://' << url
    else
      url
    end
  end

  def generate_shortened_url
    self.shortened_url = [*('A'..'Z'), *('a'..'z'), *('0'..'9')].sample(6).join
  end

  def find_or_create_site
    domain = extract_domain(self.url)
    self.site = Site.find_or_create_by(domain: domain)
  end

  def fetch_page_metadata
    page = HTTParty.get(self.url)
    self.title = extract_title_from_html(page.body)
  end

  def extract_title_from_html(page)
    Nokogiri::HTML.parse(page).title
  end

  def extract_domain(url)
    URI(url).host
  end
end