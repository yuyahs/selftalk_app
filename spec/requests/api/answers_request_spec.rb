require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:user){create(:user)}
  context "ログイン済みユーザーの場合" do
      before do
        log_in_as user
        questions = create_list(:question, 10)
      end

      describe "GET /index" do
        let!(:answer){create(:answer)}
        it "成功レスポンス200を返す" do
          get '/api/answers'
          expect(response).to have_http_status "200"
        end
      end

      describe "GET /new" do
        it "成功レスポンス200を返す" do
          get new_api_answer_path(mode_num: 1)
          expect(response).to have_http_status "200"
        end
      end

      describe "POST /create" do
        let(:question){create(:question)}

        context "answserが空欄ではない場合" do
          it "answerを保存しレスポンス200を返す" do
            expect{
            post api_answers_path, params: {id: question.id, answer: {content: "test"}}
            }.to change(Answer, :count).by(1)
            expect(response).to have_http_status "200"
          end
        end
        context "answerが空欄の場合" do
          it "answerが保存されずレスポンス204を返す" do
            expect{
            post api_answers_path, params: {id: question.id, answer: {content: ""}}
            }.to change(Answer, :count).by(0)
            expect(response).to have_http_status "204"
          end
        end
      end






    describe "GET /edit" do
      let(:answer){create(:answer, user_id: user.id)}

      it "成功レスポンス200を返す" do
        get edit_api_answer_path(answer)

        expect(response).to have_http_status "200"
      end
    end

    describe "PATCH /update" do
      let(:answer){create(:answer, user_id: user.id)}
      context  "textが空の場合" do
        it "エラー400を返す" do
          patch api_answer_path(answer), params: {answer: {content: ""}}
          expect(response).to have_http_status "400"
        end
      end

      context "textが空でない場合" do
        it "成功レスポンス200を返す" do
          patch api_answer_path(answer), params: {answer: {content: "change"}}
          expect(response).to have_http_status "200"
        end
      end
    end
  end


  context "ログイン済みでないユーザーの場合" do

    describe "GET /index" do
      it "redirects to login path" do
        get '/api/answers'
        expect(response).to redirect_to login_path
      end
    end
    #そのほかのアクションについては省略
  end
end




