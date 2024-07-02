# # spec/system/quotes_spec.rb

require "rails_helper"
include Warden::Test::Helpers

RSpec.describe "Quotes", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    @user = create(:user, company_name: "KPMG")
    login_as @user 
    # @quote = FactoryBot.create(:first_quote)
  end

  let!(:quote) { create(:quote, name: "Example Quote", company: @user.company) }

  it "shows a quote" do
    visit quotes_path
    click_link quote.name

    expect(page).to have_selector "h1", text: quote.name
  end

  it "creates a new quote", :js do
    visit quotes_path
    expect(page).to have_selector "h1", text: "Quotes"

    click_on "New quote"
    fill_in "Name", with: "Capybara quote"

    expect(page).to have_selector "h1", text: "Quotes"
    click_on "Create quote"

    expect(page).to have_selector "h1", text: "Quotes"
    expect(page).to have_text "Capybara quote"
  end

  it "updates a quote", :js do
    visit quotes_path
    expect(page).to have_selector "h1", text: "Quotes"

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated quote"

    expect(page).to have_selector "h1", text: "Quotes"
    click_on "Update quote"

    expect(page).to have_selector "h1", text: "Quotes"
    expect(page).to have_text "Updated quote"
  end

  it "destroys a quote" do
    visit quotes_path
    expect(page).to have_text quote.name

    click_on "Delete", match: :first
    expect(page).not_to have_text quote.name
  end

end