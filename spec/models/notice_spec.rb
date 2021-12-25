require 'rails_helper'

RSpec.describe Notice, type: :model do
  let(:notice){create(:notice)}

  it "titleが空白の時、無効" do
    notice.title = ""
    expect(notice).to_not be_valid
  end

  it "contentが空白の時、無効" do
    notice.content = ""
    expect(notice).to_not be_valid
  end

  it "titleが255字以上の時、無効" do
    notice.title = "a" * 256
    expect(notice).to_not be_valid
  end

  it "contentが255字以上の時、無効" do
    notice.content = "a" * 256
    expect(notice).to_not be_valid
  end

  it "titleが255字以下の時、有効" do
    notice.title = "a" * 255
    expect(notice).to be_valid
  end

  it "contentが255字以下の時、有効" do
    notice.content = "a" * 255
    expect(notice).to be_valid
  end

end
