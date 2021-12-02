require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:user){create(:user)}
  let(:question){create(:question)}
  let(:answer){create(:answer, user_id: user.id)}

  context "ログイン済みユーザーの場合" do
      before do
        log_in_as user
        questions = create_list(:question, 10)
      end

      describe "GET/ index" do
        let!(:answer){create(:answer)}
        it "成功レスポンス200を返す" do
          get api_answers_path
          expect(response).to have_http_status "200"
        end
      end

      describe "GET/ new" do
        it "成功レスポンス200を返す" do
          get new_api_answer_path(mode_num: 1)
          expect(response).to have_http_status "200"
        end
      end

      describe "POST/ create" do
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

    describe "GET/ edit" do
      it "成功レスポンス200を返す" do
        get edit_api_answer_path(answer)
        expect(response).to have_http_status "200"
      end
    end

    describe "PATCH/ update" do
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
    describe "GET/ index" do
      it "login_pathにリダイレクトする" do
        get api_answers_path
        expect(response).to redirect_to login_path
      end
    end

    describe "GET/ new" do
      it "login_pathにリダイレクトする" do
        get new_api_answer_path(mode_num: 1)
        expect(response).to redirect_to login_path
      end
    end

    describe "POST/ create" do
      it "answerが作成されず、login_pathにリダイレクトする" do
        expect{
          post api_answers_path, params: {id: question.id, answer: {content: "test"}}
          }.to change(Answer, :count).by(0)
          expect(response).to redirect_to login_path
      end
    end

    describe "GET/ edit" do
      it "login_pathにリダイレクトする" do
        get edit_api_answer_path(answer)
        expect(response).to redirect_to login_path
      end
    end

    describe "PATCH/ update" do
      it "login_pathにリダイレクトする" do
        patch api_answer_path(answer), params: {answer: {content: "change"}}
        expect(response).to redirect_to login_path
      end
    end
  end

  context "ゲストログイン中の場合" do
    before do
      guest_login
    end

    describe "GET/ index" do
      it "root_pathにリダイレクトする" do
        get api_answers_path
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ edit" do
      it "root_pathにリダイレクトする" do
        get edit_api_answer_path(answer)
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH/ update" do
      it "login_pathにリダイレクトする" do
        patch api_answer_path(answer), params: {answer: {content: "change"}}
        expect(response).to redirect_to root_path
      end
    end
  end
end




