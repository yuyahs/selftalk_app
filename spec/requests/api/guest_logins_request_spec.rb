require 'rails_helper'

RSpec.describe "Api::GuestLogins", type: :request do

  describe "POST/ guest_sign_in" do

    it "成功レスポンス200を返す" do
      post api_guest_sign_in_path
      expect(response).to have_http_status "200"
    end

    context "通常ログイン時の場合" do
      let(:user){create(:user)}
      before do
        log_in_as user
      end

      it "エラー400を返す" do
        post api_guest_sign_in_path
       expect(response).to have_http_status "400"
      end
    end
  end
end
