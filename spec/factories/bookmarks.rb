FactoryGirl.define do
  factory :bookmark do
    url 'http://example.com'

    factory :bookmark_with_tags do
      after(:create) do |bookmark|
        create_list(:tag, 2, bookmarks: [bookmark])
      end
    end
  end
end