require 'spec_helper'

describe Bookmark do
  describe '#tags_list' do
    it 'prints the list of tags separated by a space' do
      bookmark = create(:bookmark_with_tags)

      expect(bookmark.tags_list).to eq 'Tag1 Tag2'
    end
  end

  describe 'Validations' do
    it 'successfully validates a bookmark with tags and a URL' do
      expect(build(:bookmark, tags_list: 'Tag1, Tag2')).to be_valid
    end
  end
end