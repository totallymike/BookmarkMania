require 'spec_helper'

describe Tag do
  it 'renders the name as a string' do
    tag = create(:tag)
    expect(tag.to_s).to eq tag.name
  end
end
