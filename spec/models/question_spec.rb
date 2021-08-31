require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question){create(:question)}

  it "is invalid without content" do
    question.content = ""
    expect(question).to_not be_valid
  end
end
