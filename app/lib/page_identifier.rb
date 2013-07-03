class PageIdentifier
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def assign_attributes!
    record.url = find_canonical_url(record)
    record.title = fetch_page_title(record)
  end

  private
  def find_canonical_url(record)
    url = formulate_url(record.url)
    res = HTTParty.head(url, follow_redirects: false)
     if res.code == 301
       res = HTTParty.head(
           res.headers['location'], maintain_method_across_redirects: true
       )
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

  def fetch_page_title(record)
    page = HTTParty.get(record.url)
    extract_title_from_html(page.body)
  end

  def extract_title_from_html(page)
    Nokogiri::HTML.parse(page).title
  end
end