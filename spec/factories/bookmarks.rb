FactoryGirl.define do
  factory :bookmark do
    url 'http://example.com/page1'

    factory :bookmark_with_tags do
      after(:create) do |bookmark|
        create(:tag, name: 'Tag1', bookmarks: [bookmark])
        create(:tag, name: 'Tag2', bookmarks: [bookmark])
      end
    end
  end
end