require 'spec_helper'

describe Bookmark do
  describe '#tags_list' do
    it 'prints the list of tags separated by a space' do
      bookmark = create(:bookmark_with_tags)

      expect(bookmark.tags_list).to eq 'Tag1 Tag2'
    end
  end

  describe 'Site' do
    it 'correlates a bookmark to a site' do
      bookmark = create(:bookmark)
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