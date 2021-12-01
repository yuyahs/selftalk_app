require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){create(:user)}


  it "nameが空欄の時、無効" do
    user.name = "    "
    expect(user).to_not be_valid
  end


  it "nameが51字以上の時、無効" do
    user.name = "a" * 51
    expect(user).to_not be_valid
  end


  it "emailが空欄の時、無効" do
    user.email = "   "
    expect(user).to_not be_valid
  end

  it "emailが256字以上の時、無効" do
    user.email = "a" *256
    expect(user).to_not be_valid
  end

  it "適切なemailアドレスを有効と判定する" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
       user.email = valid_address
       expect(user).to be_valid
    end
  end

  it "不適正綱emailアドレスを無効と判断する" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid
    end
  end

  it "同一userの保存を無効にする" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to_not be_valid
  end


  it "passwordが空欄の時、無効" do
    user.password = " " * 6
    expect(user).to_not be_valid
  end

  it "passwordが5字以下の時、無効" do
    user.password = "a" * 5
    expect(user).to_not be_valid
  end

  it "passwordが6字以上かつconfirmationにも入力済みの時、有効" do
    user.password = "a" * 6
    user.password_confirmation = "a" * 6
    expect(user).to be_valid
  end

  it "password_confirmationが空欄の時、無効" do
    user.password = "a" * 6
    user.password_confirmation = " " * 6
    expect(user).to_not be_valid
  end

end
