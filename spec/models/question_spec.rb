require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question){create(:question)}

  it "is invalid without content" do
    question.content = ""
    expect(question).to_not be_valid
  end

  it "is invalid with more than 256 letters in content" do
    question.content = "a" * 256
    expect(question).to_not be_valid
  end
end
