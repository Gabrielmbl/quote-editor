FactoryBot.define do
  factory :line_item do
    name { "Default name" }
    description { "Default description" }
    quantity { 1 }
    unit_price { 1000 }
    association :line_item_date

    trait :room do
      name { "Meeting room" }
      description { "A cosy meeting room for 10 people" }
      quantity { 1 }
      unit_price { 1000 }
    end

    trait :catering do
      name { "Meal tray" }
      description { "Our delicious meal tray" }
      quantity { 10 }
      unit_price { 25 }
    end

    factory :room_today, traits: [:room] do
      association :line_item_date, factory: [:line_item_date, :today]
    end

    factory :catering_today, traits: [:catering] do
      association :line_item_date, factory: [:line_item_date, :today]
    end

    factory :room_next_week, traits: [:room] do
      association :line_item_date, factory: [:line_item_date, :next_week]
    end

    factory :catering_next_week, traits: [:catering] do
      association :line_item_date, factory: [:line_item_date, :next_week]
    end
  end
end



# # Example usage in a test
# RSpec.describe 'LineItems', type: :model do
#   it 'creates a room for today' do
#     line_item = create(:room_today)
#     expect(line_item.line_item_date.date).to eq(Date.current)
#     expect(line_item.name).to eq('Meeting room')
#   end

#   it 'creates catering for next week' do
#     line_item = create(:catering_next_week)
#     expect(line_item.line_item_date.date).to eq(Date.current + 1.week)
#     expect(line_item.name).to eq('Meal tray')
#   end
# end