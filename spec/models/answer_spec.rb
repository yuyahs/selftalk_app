require 'rails_helper'

RSpec.describe Answer, type: :model do
 let(:answer) {create(:answer)}

  it "contentが256字以上の時、無効" do
    answer.content = "a" * 256
    expect(answer).to_not be_valid
  end

  it "contentが255字以下の時、有効" do
    answer.content = "a" * 255
    expect(answer).to be_valid
  end
end
