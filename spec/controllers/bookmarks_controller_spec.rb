require 'spec_helper'

describe BookmarksController do
  it 'GET #show' do
    bookmark = create(:bookmark)
    get :show, id: bookmark
    expect(assigns(:bookmark)).to eq bookmark
  end

  describe 'POST #create' do
    let(:post_create) {post :create, bookmark: attributes_for(:bookmark)}
    it 'accepts a url and some tags and creates a bookmark' do
      expect{post_create}.to change(Bookmark, :count).by 1
    end
  end
end