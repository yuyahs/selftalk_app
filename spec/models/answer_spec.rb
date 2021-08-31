require 'rails_helper'

RSpec.describe Answer, type: :model do
 let(:answer) {create(:answer)}

  it "is invalid with more than 255 leters" do
    answer.content = "a" * 256
    expect(answer).to_not be_valid
  end

  it "is valid with less than 255 leters" do
    answer.content = "a" * 255
    expect(answer).to be_valid
  end
end
