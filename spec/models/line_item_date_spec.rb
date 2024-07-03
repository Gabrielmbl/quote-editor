require 'rails_helper'

RSpec.describe LineItemDate, type: :model do
  describe '#previous_date' do
    let(:quote) { create(:quote) }

    it 'returns the quote\'s previous date when it exists' do
      line_item_date_today = create(:line_item_date, :today, quote: quote)
      line_item_date_next_week = create(:line_item_date, :next_week, quote: quote)
      expect(line_item_date_next_week.previous_date).to eq(line_item_date_today)
    end

    it 'returns nil when the quote has no previous date' do
      line_item_date_today = create(:line_item_date, :today, quote: quote)
      expect(line_item_date_today.previous_date).to be_nil
    end
  end
end
