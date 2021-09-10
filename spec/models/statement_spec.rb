require 'rails_helper'

RSpec.describe Statement, type: :model do
  let(:statement){create(:statement)}

  it "is invalid without content" do
    statement.content = ""
    expect(statement).to_not be_valid
  end

  it "is invalid with more than 256 letters in content" do
    statement.content = "a" * 256
    expect(statement).to_not be_valid
  end
end
