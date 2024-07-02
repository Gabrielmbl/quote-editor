# spec/factories/quotes.rb

FactoryBot.define do
  factory :quote do
    transient do
      company_name { "KPMG" }  # Default company name
    end
    
    name { "First quote" }
    company { association :company, name: company_name }

    trait :second do
      name { "Second quote" }
    end

    trait :third do
      name { "Third quote" }
    end
  end
end
