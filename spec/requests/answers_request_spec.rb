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
      it "returns http success" do
        get answers_path
        expect(response.body).to include "回答一覧"
      end
    end

    describe "GET /new" do
      it "returns http success" do
        get new_answer_path
        expect(response.body).to include "Answer Questions"
      end
    end

    describe "POST /create" do
      let(:question){create(:question)}
      it "redirects to new" do
        expect{
        post answers_path, params: {id: question.id, answer: {content: "test"}}
        }.to change(Answer, :count).by(1)
        expect(response).to redirect_to new_answer_path
      end
    end


    describe "GET /edit" do
      let(:answer){create(:answer, user_id: user.id)}

      it "returns http success" do
        get edit_answer_path(answer)

        expect(response.body).to include "添削"
      end
    end

    describe "PATCH /update" do
      let(:answer){create(:answer, user_id: user.id)}

      it "renders index" do
        patch answer_path(answer), params: {answer: {content: "change"}}
        expect(flash[:success]).to eq "回答を保存しました。"
        expect(response.body).to include "添削"
      end


    end
  end

  context "ログイン済みでないユーザーの場合" do

    describe "GET /index" do
      it "redirects to login path" do
        get answers_path
        expect(response).to redirect_to login_path
      end
    end
    #そのほかのアクションについては省略
  end



end
