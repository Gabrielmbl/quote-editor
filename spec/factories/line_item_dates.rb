FactoryBot.define do
  factory :line_item_date do
    transient do
      quote_name { :first }
    end
    
    association :quote, factory: :quote, name: -> { quote_name }

    trait :today do
      date { Date.current }
      quote { association :quote, name: :first }
    end

    trait :next_week do
      date { Date.current + 1.week }
      quote { association :quote, name: :first }
    end
  end
end

