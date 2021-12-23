require 'rails_helper'

RSpec.describe Notice, type: :model do
  let(:notice){create(:notice)}

  it "contentが51字以上の時、無効" do
    notice.title = ""
    expect(notice).to_not be_valid
  end
end
