# spec/factories/quotes.rb

FactoryBot.define do
  factory :quote do
    transient do
      company_name { "KPMG" }  # Default company name
    end

    trait :first do
      name { "First quote" }
      company { association :company, name: company_name }
    end

    trait :second do
      name { "Second quote" }
      company { association :company, name: company_name }
    end

    trait :third do
      name { "Third quote" }
      company { association :company, name: company_name }
    end
  end
end
