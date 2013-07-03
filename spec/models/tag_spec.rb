require 'spec_helper'

describe Tag do
  describe '.with_bookmarks' do
    it 'omits tags with no bookmarks attached' do
      create(:bookmark, tags_list: 'Tag1')
      tag2 = create(:tag, name: 'Tag2')

      expect(Tag.with_bookmarks).to_not include(tag2)
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
