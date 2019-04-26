FactoryBot.define do
  factory :shortened_url do
    original_url { Faker::Internet.url }
    title { Faker::Internet.domain_word }
  end
end