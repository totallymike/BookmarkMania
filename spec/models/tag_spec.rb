require 'spec_helper'

describe Tag do
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
