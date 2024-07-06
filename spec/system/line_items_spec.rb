require "rails_helper"
include Warden::Test::Helpers

RSpec.describe "LineItems", type: :system do
  include ActionView::Helpers::NumberHelper

  # let(:quote) { quotes(:first) }
  # let(:line_item_date) { line_item_dates(:today) }
  # let(:line_item) { line_items(:room_today) }

  before do
    @accountant = create(:user, :accountant)
    login_as @accountant

    @quote = create(:quote, :first, company: @accountant.company)
    @line_item_date = create(:line_item_date, :today, quote: @quote)
    line_item = create(:room_today)
    @line_item = create(:room_today, line_item_date: @line_item_date)
    visit quote_path(@quote)
  end

  it "creates a new line item", :js do
    expect(page).to have_selector("h1", text: "First quote")

    within "##{dom_id(@line_item_date)}" do
      click_on "Add item", match: :first
    end
    expect(page).to have_selector("h1", text: "First quote")

    fill_in "Name", with: "Animation"
    fill_in "Quantity", with: 1
    fill_in "Unit price", with: 1234
    click_on "Create item"

    expect(page).to have_selector("h1", text: "First quote")
    expect(page).to have_text("Animation")
    expect(page).to have_text(number_to_currency(1234))
    # binding.irb
    expect(page).to have_text(number_to_currency(@quote.total_price))
  end

  it "updates a line item", :js  do
    expect(page).to have_selector("h1", text: "First quote")

    within "##{dom_id(@line_item)}" do
      click_on "Edit"
    end
    expect(page).to have_selector("h1", text: "First quote")

    fill_in "Name", with: "Capybara article"
    fill_in "Unit price", with: 1234
    click_on "Update item"

    expect(page).to have_text("Capybara article")
    expect(page).to have_text(number_to_currency(1234))
    binding.irb
    expect(page).to have_text(number_to_currency(@quote.total_price))
  end

  it "destroys a line item", :js  do
    within "##{dom_id(@line_item_date)}" do
      expect(page).to have_text(@line_item.name)
    end

    within "##{dom_id(@line_item)}" do
      click_on "Delete"
    end

    within "##{dom_id(@line_item_date)}" do
      expect(page).not_to have_text(@line_item.name)
    end
    expect(page).to have_text(number_to_currency(@quote.total_price))
  end
end
