require 'rails_helper'

RSpec.describe "Api::Notices", type: :request do
  let!(:user){create(:user, :admin)}
  let!(:notice){create(:notice)}

  context "ログイン済みユーザーが管理者の場合" do
    before do
      log_in_as user
    end

    describe "GET /index" do
      it "成功レスポンス200を返す" do
        get api_notices_path
        expect(response).to have_http_status "200"
      end
    end

    describe "GET /show" do
      it "成功レスポンス200を返す" do
        get api_notice_path(notice)
        expect(response).to have_http_status "200"
      end
    end

    describe "POST /create" do
      context "noticeが空欄ではない場合" do
        it "noticeを保存しレスポンス200を返す" do
          expect{
          post api_notices_path, params:
          { notice: {title: "test", content: "test"}}
          }.to change(Notice, :count).by(1)
          expect(response).to have_http_status "200"
        end
      end

      context "notice追加欄に空欄がある場合" do
        it "noticeが保存されずレスポンス400を返す" do
          expect{
          post api_notices_path, params:
          { notice: {title: "", content: ""}}
          }.to change(Notice, :count).by(0)
          expect(response).to have_http_status "400"
        end
      end
    end

    describe "Delete /destroy" do
      it "成功レスポンス200を返す" do
        expect{
        delete api_notice_path(notice), params: {id: notice.id}
        }.to change(Notice, :count).by(-1)
        expect(response).to have_http_status "200"
      end
    end
  end

  context "ログイン済みユーザーが管理者ではない場合" do
    let(:user){create(:user)}
    before do
      log_in_as user
    end

    describe "POST /create" do
      it "noticeを保存せずroot_pathにリダイレクトする" do
        expect{
        post api_notices_path, params:
        { notice: {title: "test", content: "test"}}
        }.to change(Notice, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    describe "Delete /destroy" do
      it "root_pathにリダイレクトする" do
        expect{
        delete api_notice_path(notice), params: {id: notice.id}
        }.to change(Notice, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end

  context "ログイン済みでないユーザーの場合" do
    describe "GET /index" do
      it "login_pathにリダイレクト" do
        get api_notices_path
        expect(response).to redirect_to login_path
      end
    end

    describe "GET /show" do
      it "login_pathにリダイレクト" do
        get api_notice_path(notice)
        expect(response).to redirect_to login_path
      end
    end

    describe "POST /create" do
      it "noticeは生成されず、login_pathにリダイレクトする" do
        expect{
          post api_notices_path, params:
          {notice: {titel: "test", content: "test"}}
          }.to change(Notice, :count).by(0)
          expect(response).to redirect_to login_path
      end
    end

    describe "Delete /destroy" do
      it "noticeは削除されず、login_pathにリダイレクトする" do
        expect{
          delete api_notice_path(notice), params: {id: notice.id}
        }.to change(Notice, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "ゲストログイン中の場合" do
    before do
      guest_login
    end

    describe "GET /index" do
      it "root_pathにリダイレクトする" do
        get api_notices_path
        expect(response).to redirect_to root_path
      end
    end

    describe "GET /show" do
      it "root_pathにリダイレクトする" do
        get api_notice_path(notice)
        expect(response).to redirect_to root_path
      end
    end

    describe "POST /create" do
      it "noticeは生成されず、root_pathにリダイレクトする" do
        expect{
          post api_notices_path, params:
          {notice: {title: "test", content: "test"}}
          }.to change(Notice, :count).by(0)
          expect(response).to redirect_to root_path
      end
    end

    describe "Delete /destroy" do
      it "noticeは削除されず、root_pathにリダイレクトする" do
        expect{
          delete api_notice_path(notice), params: {id: notice.id}
        }.to change(Notice, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
