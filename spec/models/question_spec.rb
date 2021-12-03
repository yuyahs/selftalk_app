require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question){create(:question)}

  it "contentが空の時、無効" do
    question.content = ""
    expect(question).to_not be_valid
  end

  it "contentが256字以上の時、無効" do
    question.content = "a" * 256
    expect(question).to_not be_valid
  end

  it "contentが255字以下の時、有効" do
    question.content = "a" * 255
    expect(question).to be_valid
  end
end
