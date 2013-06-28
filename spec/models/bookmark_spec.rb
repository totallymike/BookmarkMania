require 'spec_helper'

describe Bookmark do
  describe '#tags_list' do
    it 'prints the list of tags separated by a space' do
      bookmark = create(:bookmark_with_tags)

      expect(bookmark.tags_list).to eq 'Tag1 Tag2'
    end
  end
end