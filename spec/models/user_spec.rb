require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  context 'is admin user' do
    before do
      create(:admin)
    end

    it { expect(User.first.admin?).to be true }
  end

  context 'is api user' do
    before do
      create(:api)
    end

    it { expect(User.first.api?).to be true }
  end
end