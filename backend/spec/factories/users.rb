FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:email) { |n| "example_#{n}@example.com" }
    birth_place { '北海道' }
    birth_year { 1992 }
    birth_month { 4 }
    birth_day { 4 }
    gender { 'man' }
    introduction { '' }
    password { 'password' }
    password_confirmation { 'password' }

    trait :invalid_email do
      email { 'example.com' }
    end

    trait :over_length_name do
      name { 'a' * 11 }
    end

    trait :over_length_introduction do
      introduction { 'a' * 256 }
    end

    trait :valid_introduction do
      introduction { 'a' * 255 }
    end

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new('spec/fixtures/files/510534.jpg') }
    end

    trait :with_invalid_format_avatar do
      avatar { Rack::Test::UploadedFile.new('spec/fixtures/files/example.txt') }
    end

    trait :with_over_size_avatar do
      avatar { Rack::Test::UploadedFile.new('spec/fixtures/files/5.1mb_image.jpg') }
    end

    trait :age_10s do
      birth_year { 2010 }
      birth_month { 1 }
      birth_day { 1 }
    end
  end
end
