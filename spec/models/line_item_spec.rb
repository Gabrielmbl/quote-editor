require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it "#total_price returns the total price of the line item" do
    line_item = FactoryBot.create(:catering_today)  
    
    expect(line_item.total_price).to eq(250)
  end
end