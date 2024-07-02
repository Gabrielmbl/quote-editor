# spec/models/user_spec.rb

require "rails_helper"

RSpec.describe User, type: :model do
  describe "#name" do
    let(:accountant) { create(:user, email: "accountant@kpmg.com") }

    it "returns the correct name" do
      expect(accountant.name).to eq("Accountant")
    end
  end
end