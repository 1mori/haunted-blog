FactoryBot.define do
  factory :blog do
    title { '今日の出来事' }
    content { 'ボブと遊びました。' }
    secret { false }
    association :user
  end
end
