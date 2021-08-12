require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー名' do
    it 'ブランクの場合、無効な状態であること' do
      user = User.new( name: '  ',
                       email: 'user@example.com',
                       password: 'password',
                       password_confirmation: 'password')
      expect(user).to_not be_valid
    end
  end

  it '長過ぎる場合、無効な状態であること' do
    user = User.new( name: 'a' * 51,
                     email: 'user@example.com',
                     password: 'password',
                     password_confirmation: 'password')
    expect(user).to_not be_valid
  end
end
