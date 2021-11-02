require 'rails_helper'

RSpec.describe "Api::Questions", type: :request do

  context "ログイン済みの管理者ユーザーの場合" do
       let(:user){create(:user, :admin)}

        before do
          log_in_as user
        end

        describe "GET /index" do
          it "成功レスポンス200を返す" do
            get '/api/questions'
            expect(response).to have_http_status "200"
          end
        end

        describe "GET /new" do
          it  "成功レスポンス204を返す" do
            get '/api/questions/new'
            expect(response).to have_http_status "204"
          end
        end

        describe "POST /create" do
          context "空欄なく入力した場合" do
            it "成功レスポンス200を返す" do
              expect{
              post '/api/questions' ,params: { question: {content: "test", mode_num: 1}}
               }.to change(Question, :count).by (1)
               expect(response).to have_http_status "200"
            end
          end

          context "空欄があった場合" do
            it "エラーレスポンス400を返す" do
              expect{
                post '/api/questions' ,params: { question: {content: "", mode_num: ""}}
                 }.to change(Question, :count).by (0)
                 expect(response).to have_http_status "400"
            end
          end

        end

        describe "DELETE /destroy" do
          let!(:question){create(:question)}

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
         it "redirects to root path" do
           get '/api/questions'
           expect(response).to redirect_to root_path
         end
       end
       #そのほかのアクションについては省略
      end

      context "ログイン済みではないユーザーの場合" do

        describe "GET/ index" do
          it "redirects to root path" do
            get '/api/questions'
            expect(response).to redirect_to login_path
          end
        end
        #そのほかのアクションについては省略
     end



end
