# spec/factories/companies.rb

FactoryBot.define do
  factory :company do
    name { "Generic Copmany" }

    trait :kpmg do
      name { "KPMG" }
    end

    trait :pwc do
      name { "PwC" }
    end
  end
end