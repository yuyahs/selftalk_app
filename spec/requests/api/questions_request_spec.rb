require 'rails_helper'

RSpec.describe "Api::Questions", type: :request do
  let(:user){create(:user, :admin)}
  let!(:question){create(:question)}
  context "ログイン済みの管理者ユーザーの場合" do
    before do
      log_in_as user
    end

    describe "GET /index" do
      it "成功レスポンス200を返す" do
        get api_questions_path
        expect(response).to have_http_status "200"
      end
    end

    describe "POST /create" do
      context "空欄なく入力した場合" do
        it "成功レスポンス200を返す" do
          expect{
            post api_questions_path ,params: { question:
            {content: "test", mode_num: 1}}
            }.to change(Question, :count).by (1)
            expect(response).to have_http_status "200"
        end
      end

      context "空欄があった場合" do
        it "エラーレスポンス400を返す" do
          expect{
            post api_questions_path ,params: { question: {content: "", mode_num: ""}}
            }.to change(Question, :count).by (0)
            expect(response).to have_http_status "400"
        end
      end
    end

    describe "DELETE /destroy" do
      it "成功レスポンス200を返す" do
        expect{
          delete api_question_path(question), params: {id: question.id}
          }.to change(Question, :count).by(-1)
          expect(response).to have_http_status "200"
      end
    end
  end

  context "ログイン済みの管理者ではないユーザーの場合" do
    let(:user){create(:user)}

    before do
      log_in_as user
    end

    describe "GET/ index" do
      it "root_pathにリダイレクトする" do
        get api_questions_path
        expect(response).to redirect_to root_path
      end
    end

    describe "POST/ create" do
      it "questionは生成されず、root_pathにリダイレクトする" do
        expect{
          post api_questions_path ,params: { question:
          {content: "test", mode_num: 1}}
          }.to change(Question, :count).by (0)
          expect(response).to redirect_to root_path
      end
    end

    describe "DELETE/ destroy" do
      it "questionは削除されず、root_pathにリダイレクトされる" do
        expect{
          delete api_question_path(question), params: {id: question.id}
          }.to change(Question, :count).by(0)
          expect(response).to redirect_to root_path
      end
    end
  end

  context "ログイン済みではないユーザーの場合" do
    describe "GET/ index" do
      it "login_pathにリダイレクトする" do
        get api_questions_path
        expect(response).to redirect_to login_path
      end
    end

    describe "POST/ create" do
      it "questionは生成されず、login_pathにリダイレクトする" do
        expect{
          post api_questions_path ,params: { question:
          {content: "test", mode_num: 1}}
          }.to change(Question, :count).by (0)
          expect(response).to redirect_to login_path
      end
    end

    describe "DELETE/ destroy" do
      it "questionは削除されず、login_pathにリダイレクトされる" do
        expect{
          delete api_question_path(question), params: {id: question.id}
          }.to change(Question, :count).by(0)
          expect(response).to redirect_to login_path
      end
    end
  end
end
