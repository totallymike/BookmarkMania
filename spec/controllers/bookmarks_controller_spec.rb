require 'spec_helper'

describe BookmarksController do
  describe 'GET #show' do
    it 'presents a bookmark upon success' do
      bookmark = create(:bookmark)
      get :show, id: bookmark
      expect(assigns(:bookmark)).to eq bookmark
    end
  end

  describe 'POST #create' do
    let(:post_no_tags) {
      post :create,
        bookmark: attributes_for(:bookmark)
    }

    let(:post_create) {
      post :create,
        bookmark: attributes_for(:bookmark, tags_list: 'Tag1, Tag2')
    }

    it 'accepts a url and some tags and creates a bookmark' do
      expect{post_create}.to change(Bookmark, :count).by 1
    end

    it 'accepts a url and no tags and creates a bookmark' do
      expect{post_no_tags}.to change(Bookmark, :count).by 1
    end

    it 'presents an error if no URL is provided' do
      post :create, bookmark: {url: nil}
      expect(flash[:error]).to eq 'URL required'
      expect(response).to redirect_to root_url
    end

    describe 'tag generation' do
      it 'instantiates tags from the provided list' do
        expect{post_create}.to change(Tag, :count).by 2
      end

      it 'Does not recreate tags that already exist' do
        create(:tag, name: 'Tag1')
        create(:tag, name: 'Tag2')
        expect{post_create}.to change(Tag, :count).by 0
      end
    end

    describe 'site generation' do
      it 'associates the bookmark with a Site related to its domain' do
        expect{post_create}.to change(Site, :count).by 1
      end
    end
  end
end