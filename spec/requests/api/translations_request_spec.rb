require 'rails_helper'

RSpec.describe "Api::Translations", type: :request do
  let(:question){create(:question)}

  describe "GET/ translate(DeepL api)" do

    it "response200を返す" do
      get api_path(question)
      expect(response).to have_http_status 200
    end

  end
end
