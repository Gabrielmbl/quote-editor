# spec/factories/companies.rb

FactoryBot.define do
  factory :company do
    name { "KPMG" }

    factory :pwc do
      name { "PwC" }
    end
  end
end