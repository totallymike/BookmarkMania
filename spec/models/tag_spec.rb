require 'spec_helper'

describe Tag do
  describe '.with_bookmarks' do
    it 'omits tags with no bookmarks attached' do
      create(:bookmark, tags_list: 'Tag1')
      tag2 = create(:tag, name: 'Tag2')

      expect(Tag.with_bookmarks).to_not include(tag2)
    end
  end

  describe '.with_bookmarks_for_user' do
    it 'only shows bookmarks belonging to a certain user' do
      user = create(:user)
      tag1 = create(:bookmark, tags_list: 'Tag1', user_id: user.id)
      tag2 = create(:bookmark, url: 'http://example.com/page2', tags_list: 'Tag2')
      expect(Tag.with_bookmarks_for_user(user)).to include(tag1)
      expect(Tag.with_bookmarks_for_user(user)).to_not include(tag2)
    end
  end

  describe '#bookmarks_from_user' do
    it 'only shows bookmarks belonging to a certain user' do
      user = create(:user)
      bookmark1 = create(:bookmark, tags_list: 'Tag1', user_id: user.id)
      bookmark2 = create(:bookmark, url: 'http://example.com/page2', tags_list: 'Tag1')
      tag = Tag.find_by(name: 'Tag1')
      expect(tag.bookmarks_from_user(user)).to include(bookmark1)
      expect(tag.bookmarks_from_user(user)).to_not include(bookmark2)
    end
  end

  it 'renders the name as a string' do
    tag = create(:tag)
    expect(tag.to_s).to eq tag.name
  end

  describe 'Validations' do
    it 'enforces uniqueness of tags' do
      create(:tag, name: 'Tag1')
      expect(build(:tag, name: 'Tag1')).to have(1).errors_on(:name)
    end
  end
end
