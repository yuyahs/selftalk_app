require 'rails_helper'

RSpec.describe "Api::Contacts", type: :request do

  describe "GET/ new" do
    it "成功レスポンス204を返す" do
      get new_api_contact_path
      expect(response).to have_http_status "204"
    end
  end

  describe "POST/ create" do
    context "名前が空欄でメッセージは入力されている場合" do
      it "エラーレスポンス400を返す" do
        expect{
          post api_contacts_path, params: {inquiry: {name: "", message: "message"}}
        }.to change(Inquiry, :count).by(0)
        expect(ActionMailer::Base.deliveries.size).to eq(0)
        expect(response).to have_http_status "400"
      end
    end
    context "名前が入力されていてでメッセージは空の場合" do
      it "エラーレスポンス400を返す" do
        expect{
          post api_contacts_path, params: {inquiry: {name: "user", message: ""}}
        }.to change(Inquiry, :count).by(0)
        expect(ActionMailer::Base.deliveries.size).to eq(0)
        expect(response).to have_http_status "400"
      end
    end
    context "名前もメッセージも入力されている場合" do
      it "成功レスポンス200を返す" do
        expect{
          post api_contacts_path, params: {inquiry: {name: "user", message: "message"}}
        }.to change(Inquiry, :count).by(1)
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(response).to have_http_status "200"
      end
    end
  end
end
