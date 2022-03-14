FactoryBot.define do
  factory :taste do
    sequence(:content) { |n| "content#{n}" }
  end
end
