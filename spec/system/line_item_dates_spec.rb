# spec/system/line_item_dates_spec.rb

require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'LineItemDates', type: :system do
  before do
    # driven_by(:selenium_chrome_headless)
    @user = create(:user, :accountant)
    login_as @user

    @quote = create(:quote, :first, company: @user.company)
    @line_item_date = create(:line_item_date, :today, quote: @quote)
    
    visit quote_path(@quote)
  end

  it 'creates a new line item date', :js do

    expect(page).to have_selector 'h1', text: 'First quote'

    click_on 'New date'
    expect(page).to have_selector 'h1', text: 'First quote'
    fill_in 'Date', with: Date.current + 1.day

    click_on 'Create date'
    expect(page).to have_text I18n.l(Date.current + 1.day, format: :long)
  end
  

  it 'updates a line item date', :js do
    expect(page).to have_selector 'h1', text: 'First quote'

    within "##{dom_id(@line_item_date)}" do
      click_on 'Edit'
    end

    expect(page).to have_selector 'h1', text: 'First quote'

    fill_in 'Date', with: Date.current + 1.day
    click_on 'Update date'

    expect(page).to have_text I18n.l(Date.current + 1.day, format: :long)
  end

  it 'destroys a line item date', :js do
    expect(page).to have_text I18n.l(Date.current, format: :long)

    accept_confirm do
      within "##{dom_id(@line_item_date)}" do
        click_on 'Delete'
      end
    end

    expect(page).not_to have_text I18n.l(Date.current, format: :long)
  end
end
