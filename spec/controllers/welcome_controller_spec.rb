require 'spec_helper'

describe WelcomeController do
  describe '#index' do
    it 'assigns a new bookmark to @bookmark' do
      get :index
      expect(assigns(:bookmark)).to be_a_new(Bookmark)
    end
  end
end