require 'rails_helper'

RSpec.describe "Questions", type: :request do
 context "ログイン済みの管理者ユーザーの場合" do
   let(:user){create(:user, :admin)}

    before do
      log_in_as user
    end

    describe "GET /index" do
      it "renders index" do
        get questions_path
        expect(response.body).to include "問題一覧"
      end
    end

    describe "GET /new" do
      it "renders new" do
        get new_question_path
        expect(response.body).to include "Create Questions"
      end
    end

    describe "POST /create" do
      context "空欄なく入力した場合" do
        it "redirects to root path" do
          expect{
          post questions_path, params: {form_question_collection:
                                      {questions_attributes:
                                      {0=> {content: "test question1"},
                                        1 =>{content: "test question2"},
                                        2 =>{content: "test question3"},
                                        3 =>{content: "test question4"},
                                        4 =>{content: "test question5"},
                                        5 =>{content: "test question6"},
                                        6 =>{content: "test question7"},
                                        7 =>{content: "test question8"},
                                        8 =>{content: "test question9"},
                                        9 =>{content: "test question10"}}}}
           }.to change(Question, :count).by (10)
          expect(response).to redirect_to root_path
        end
      end

      context "空欄があった場合" do
        it "render new" do
          post questions_path, params: {form_question_collection:
            {questions_attributes:
            {0=> {content: ""}}}}

          expect(response.body).to include "Create Questions"
        end
      end

    end

    describe "DELETE /destroy" do
      let!(:question){create(:question)}

      it "redirects to index" do
        expect{
          delete question_path(question), params: {id: question.id}
        }.to change(Question, :count).by(-1)
        expect(response).to redirect_to questions_path
      end
    end
  end

 context "ログイン済みの管理者ではないユーザーの場合" do
   let(:user){create(:user)}

   before do
     log_in_as user
   end

   describe "GET/ index" do
     it "redirects to root path" do
       get new_question_path
       expect(response).to redirect_to root_path
     end
   end
   #そのほかのアクションについては省略
  end

  context "ログイン済みではないユーザーの場合" do

    describe "GET/ index" do
      it "redirects to root path" do
        get new_question_path
        expect(response).to redirect_to login_path
      end
    end
    #そのほかのアクションについては省略
  end



end
