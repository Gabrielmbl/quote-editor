require 'rails_helper'

RSpec.describe Quote, type: :model do
  it "#total_price returns the sum of the total price of all line items" do
    quote = create(:quote)

    line_item_date_today = create(:line_item_date, :today, quote: quote)
    line_item_date_next_week = create(:line_item_date, :next_week, quote: quote)
    create_list(:room_today, 1, line_item_date: line_item_date_today)
    create_list(:catering_today, 1, line_item_date: line_item_date_today)
    create_list(:room_next_week, 1, line_item_date: line_item_date_next_week)
    create_list(:catering_next_week, 1, line_item_date: line_item_date_next_week)

    expect(quote.total_price).to eq(2500)
  end
end

