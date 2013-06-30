require 'spec_helper'

describe Bookmark do
  let(:bookmark) { create(:bookmark) }
  let(:bookmark_with_redirect) {
    create(:bookmark,
      url: 'http://example.com/will_redirect_to_page1')
  }

  describe '#url' do
    it 'uses canonical URLs when necessary' do
      expect(bookmark_with_redirect.url).to eq 'http://example.com/page1'
    end
  end

  describe '#tags_list' do
    it 'prints the list of tags separated by a space' do
      bookmark = create(:bookmark_with_tags)

      expect(bookmark.tags_list).to eq 'Tag1 Tag2'
    end
  end

  describe '#shortened_url' do
    it 'associates a shortened URL with each bookmark' do
      expect(bookmark.shortened_url).to match %r[\w{5}]
    end
  end

  describe '#title' do
    it 'fetches the title of the actual web site from the provided URL' do
      expect(bookmark.title).to eq 'Example Page Number 1!'
    end
    it 'follows redirects too' do
      expect(bookmark_with_redirect.title).to eq 'Example Page Number 1!'
    end
  end

  describe 'Site' do
    it 'correlates a bookmark to a site' do
      expect(bookmark.site.domain).to eq 'example.com'
      bookmark = create(:bookmark, url: 'http://www.reddit.com/r/ruby')
      expect(bookmark.site.domain).to eq 'www.reddit.com'
    end
  end

  describe 'Validations' do
    it 'successfully validates a bookmark with tags and a URL' do
      expect(build(:bookmark, tags_list: 'Tag1, Tag2')).to be_valid
    end

    it 'refuses to validate a bookmark without a URL' do
      expect(build(:bookmark, url: nil)).to have(1).errors_on :url
    end
  end
end
