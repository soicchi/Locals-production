FactoryBot.define do
  factory :relationship do
    sequence(:follower_id) { |n| n }
    sequence(:followed_id) { |n| n }
  end
end
