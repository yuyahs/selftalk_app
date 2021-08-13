require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example", email: "user@example.com",
                     password: 'password', password_confirmation: 'password')
  end


  it 'is invalid without a name' do
    @user.name = "    "
    expect(@user).to_not be_valid
  end


  it 'is invalid with more than 51 letters' do
    @user.name = "a" * 51
    expect(@user).to_not be_valid
  end


  it 'is invalid without an email' do
    @user.email = "   "
    expect(@user).to_not be_valid
  end

  it 'is invalid with more than 256 letters' do
    @user.email = "a" *256
    expect(@user).to_not be_valid
  end

  it 'accepts valid email addresses ' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
       @user.email = valid_address
       expect(@user).to be_valid
    end
  end

  it 'rejects invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to_not be_valid
    end
  end

  it 'is valid with uniqueness' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to_not be_valid
  end


  it "is invalid without password" do
    @user.password = " " * 6
    expect(@user).to_not be_valid
  end

  it "is invalid with more than 7 letters" do
    @user.password = "a" * 7
    expect(@user).to_not be_valid
  end

   #for FactoryBot testing
  # it "is invalid with a duplicate email address" do
  #   FactoryBot.create(:user, email: "aaron@example.com")
  #   user = FactoryBot.build(:user, email: "aaron@example.com")
  #   user.valid?
  #   expect(user.errors[:email]).to include("has already been taken")
  # end
end
