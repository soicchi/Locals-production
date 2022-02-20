FactoryBot.define do
  factory :post do
    sequence(:comment) { |n| "example_comment_#{n}" }
    sequence(:restaurant_name) { |n| "example_restaurant_#{n}" }
    station { '渋谷' }
    after(:build) do |post|
      post.category_ids << build(:category)
    end
    # after(:build) do |post|
    #   post.images.attach(io: File.open('spec/fixtures/files/5.1mb_image.jpg'), filename: '5.1mb_image.jpg', content_type: 'image/jpg')
    # end
    association :user

    trait :valid_comment do
      comment { 'a' * 255 }
    end

    trait :invalid_comment do
      comment { 'a' * 256 }
    end
  end
end
