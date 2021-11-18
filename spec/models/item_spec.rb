require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item){create(:item)}

  it "is invalid with more than 50 leters in content" do
    item.content = "a" * 51
    expect(item).to_not be_valid
  end

  it "is invalid with more than 50 leters in meaning" do
    item.meaning = "a" * 51
    expect(item).to_not be_valid
  end
  it "is invalid with more than 50 leters in memo" do
    item.memo = "a" * 101
    expect(item).to_not be_valid
  end

  it "is valid with less than 50 leters in content" do
    item.content = "a" * 50
    expect(item).to be_valid
  end
  it "is valid with less than 50 leters in meaning" do
    item.meaning = "a" * 50
    expect(item).to be_valid
  end

  it "is valid with less than 100 leters in memo" do
    item.memo = "a" * 100
    expect(item).to be_valid
  end
end
