require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  let(:inquiry){create(:inquiry)}

  it "nameが空欄の時、無効" do
    inquiry.name = ""
    expect(inquiry).to_not be_valid
  end

  it "nameが256字以上の時、無効" do
    inquiry.name = "a" * 256
    expect(inquiry).to_not be_valid
  end

  it "nameが255字以下の時、有効" do
    inquiry.name = "a" * 255
    expect(inquiry).to be_valid
  end

  it "messageが空欄の時、無効" do
    inquiry.message = ""
    expect(inquiry).to_not be_valid
  end

  it "messageが501字以上の時、無効" do
    inquiry.message = "a" * 501
    expect(inquiry).to_not be_valid
  end
  
  it "messageが500字以下の時、有効" do
    inquiry.message = "a" * 500
    expect(inquiry).to be_valid
  end

end
