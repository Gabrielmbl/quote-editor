# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    transient do
      company_name { "KPMG" }  # Default company name
    end
    
    email { "accountant@#{company_name.downcase}.com" }
    encrypted_password { Devise::Encryptor.digest(User, 'password') }
    company { association :company, name: company_name }

    factory :manager do
      email { "manager@#{company_name.downcase}.com" }
      encrypted_password { Devise::Encryptor.digest(User, 'password') }
    end

    factory :eavesdropper do
      company_name { "PwC" }  # Override company name for eavesdropper
      email { "eavesdropper@#{company_name.downcase}.com" }
      encrypted_password { Devise::Encryptor.digest(User, 'password') }
      company { association :company, name: company_name }
    end
  end
end
