require 'spec_helper'

describe Site do
  describe '#title' do
    it 'displays the title of the root page on a domain' do
      root_bookmark = create(:bookmark, url: 'http://example.com')
      bookmark = create(:bookmark, url: 'http://example.com/page1')

      expect(root_bookmark.site.title).to eq 'Example!'
      expect(bookmark.site.title).to eq root_bookmark.site.title
    end
  end
end
