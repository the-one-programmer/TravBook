require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  let(:user) { build(:user) }
  let(:second_user) {build(:user)}
  let(:password) { attributes_for(:user)[:password] }

  describe "ActiveModel validations" do
    # Basic validations (using Shoulda)

  end

  describe '#follow' do
    before do
      user.save
      second_user.save
      user.follow(second_user.id)
    end
    it 'can follow someone' do
      expect(user.followeds.count).to eq 1
      expect(second_user.followers.count).to eq 1
    end

    it 'can unfollow someone' do
      user.unfollow(second_user.id)
      expect(user.followeds.count).to eq 0
      expect(second_user.followers.count).to eq 0
    end


  end
end
