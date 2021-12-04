require 'rails_helper'

RSpec.describe "Api::Items", type: :request do
  let(:user){create(:user)}
  let!(:item){create(:item, user_id: user.id)}
  context "ログイン済みユーザーの場合" do
    before do
      log_in_as user
    end

    describe "GET /index" do
      let!(:item){create(:item)}
      it "成功レスポンス200を返す" do
        get user_api_items_path(user)
        expect(response).to have_http_status "200"
      end
    end

    describe "POST /create" do
      context "itemが空欄ではない場合" do
        it "itemを保存しレスポンス200を返す" do
          expect{
          post api_items_path, params:
          {id: user.id, item: {content: "test", meaning: "test", memo:"test"}}
          }.to change(Item, :count).by(1)
          expect(response).to have_http_status "200"
        end
      end
      context "item追加欄に空欄がある場合" do
        it "answerが保存されずレスポンス400を返す" do
          expect{
          post api_items_path, params:
          {id: user.id, item: {content: "", meaning:"test", memo:"test"}}
          }.to change(Item, :count).by(0)
          expect(response).to have_http_status "400"
        end
      end
    end

    describe "Delete /destroy" do
      it "成功レスポンス200を返す" do
        expect{
        delete api_item_path(item), params: {id: item.id}
        }.to change(Item, :count).by(-1)
        expect(response).to have_http_status "200"
      end
    end
  end

  context "ログイン済みでないユーザーの場合" do
    describe "GET /index" do
      it "redirects to login path" do
        get user_api_items_path(user)
        expect(response).to redirect_to login_path
      end
    end

    describe "POST /create" do
      it "itemは生成されず、login_pathにリダイレクトする" do
        expect{
          post api_items_path, params:
          {id: user.id, item: {content: "test", meaning: "test", memo:"test"}}
          }.to change(Item, :count).by(0)
          expect(response).to redirect_to login_path
      end
    end

    describe "Delete /destroy" do
      it "itemは削除されず、login_pathにリダイレクトする" do
        expect{
          delete api_item_path(item), params: {id: item.id}
        }.to change(Item, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "ゲストログイン中の場合" do
    before do
      guest_login
    end

    describe "GET /index" do
      it "redirects to root_path" do
        get user_api_items_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "POST /create" do
      it "itemは生成されず、root_pathにリダイレクトする" do
        expect{
          post api_items_path, params:
          {id: user.id, item: {content: "test", meaning: "test", memo:"test"}}
          }.to change(Item, :count).by(0)
          expect(response).to redirect_to root_path
      end
    end

    describe "Delete /destroy" do
      it "itemは削除されず、root_pathにリダイレクトする" do
        expect{
          delete api_item_path(item), params: {id: item.id}
        }.to change(Item, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
