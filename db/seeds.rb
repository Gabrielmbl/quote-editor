# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Require the necessary files to access FactoryBot
require 'factory_bot_rails'

# Create companies
kpmg = Company.find_or_create_by(name: "KPMG")
pwc = Company.find_or_create_by(name: "PWC")

# Create users associated with companies
unless User.exists?(email: "accountant@kpmg.com")
  FactoryBot.create(:user, email: "accountant@kpmg.com", password: 'password', company: kpmg)
end

unless User.exists?(email: "manager@kpmg.com")
  FactoryBot.create(:user, email: "manager@kpmg.com", password: 'password', company: kpmg)
end

unless User.exists?(email: "eavesdropper@pwc.com")
  FactoryBot.create(:user, email: "eavesdropper@pwc.com", password: 'password', company: pwc)
end

# Find or create quotes associated with companies
first_quote = Quote.find_or_create_by(name: "First quote", company: kpmg)
second_quote = Quote.find_or_create_by(name: "Second quote", company: kpmg)

# Create line_item_dates associated with quotes
line_item_date_today = LineItemDate.find_or_create_by(date: Date.current, quote: first_quote) do |line_item_date|
  line_item_date.quote = first_quote
end

line_item_date_next_week = LineItemDate.find_or_create_by(date: Date.current + 1.week, quote: second_quote) do |line_item_date|
  line_item_date.quote = second_quote
end


# Create line_items associated with line_item_dates
LineItem.find_or_create_by(line_item_date: line_item_date_today, name: "Meeting room") do |line_item|
  line_item.description = "A cosy meeting room for 10 people"
  line_item.quantity = 1
  line_item.unit_price = 1000
end

LineItem.find_or_create_by(line_item_date: line_item_date_today, name: "Meal tray") do |line_item|
  line_item.description = "Our delicious meal tray"
  line_item.quantity = 10
  line_item.unit_price = 25
end

LineItem.find_or_create_by(line_item_date: line_item_date_next_week, name: "Meeting room") do |line_item|
  line_item.description = "A cosy meeting room for 10 people"
  line_item.quantity = 1
  line_item.unit_price = 1000
end

LineItem.find_or_create_by(line_item_date: line_item_date_next_week, name: "Meal tray") do |line_item|
  line_item.description = "Our delicious meal tray"
  line_item.quantity = 10
  line_item.unit_price = 25
end


puts "\n== Seeding the database with fixtures =="
system("bin/rails db:fixtures:load")
