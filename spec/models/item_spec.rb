require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item){create(:item)}

  it "contentが51字以上の時、無効" do
    item.content = "a" * 51
    expect(item).to_not be_valid
  end

  it "maniengが51字以上の時、無効" do
    item.meaning = "a" * 51
    expect(item).to_not be_valid
  end
  it "memoが101字以上の時、無効" do
    item.memo = "a" * 101
    expect(item).to_not be_valid
  end

  it "contentが50字以下の時、有効" do
    item.content = "a" * 50
    expect(item).to be_valid
  end
  it "maniengが50字以下の時、有効" do
    item.meaning = "a" * 50
    expect(item).to be_valid
  end

  it "memoが100字以下の時、有効" do
    item.memo = "a" * 100
    expect(item).to be_valid
  end
end
