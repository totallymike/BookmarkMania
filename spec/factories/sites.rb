# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    title "Examples!"
    domain 'example.com'
  end
end
