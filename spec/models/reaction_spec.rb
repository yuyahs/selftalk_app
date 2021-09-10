require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:reaction){create(:reaction)}

  it "is invalid with more than 255 leters" do
    reaction.content = "a" * 256
    expect(reaction).to_not be_valid
  end

  it "is valid with less than 255 leters" do
    reaction.content = "a" * 255
    expect(reaction).to be_valid
  end
end
