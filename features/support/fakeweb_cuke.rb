require 'fakeweb'

FakeWeb.allow_net_connect = false

page_body = <<-end_of_page
  <!DOCTYPE html>
  <html>
    <head><title>Example Page Number 1!</title></head>
    <body>A web page.</body>
  </html>
end_of_page

FakeWeb.register_uri(:any, 'http://example.com/page1', body: page_body)
