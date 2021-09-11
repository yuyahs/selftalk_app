require 'rails_helper'

RSpec.describe "Reactions", type: :request do
  let(:user){create(:user)}
  context "ログイン済みユーザーの場合" do
    before do
      log_in_as user
      statements = create_list(:statement, 10)
    end

    describe "GET /index" do
      let!(:reaction){create(:reaction)}
      it "returns http success" do
        get reactions_path
        expect(response.body).to include "reactions一覧"
      end
    end

    describe "GET /new" do
      it "returns http success" do
        get new_reaction_path
        expect(response.body).to include "React Statements"
      end
    end

    describe "POST /create" do
      let(:statement){create(:statement)}
      it "redirects to new" do
        expect{
        post reactions_path, params: {id: statement.id, reaction: {content: "test"}}
        }.to change(Reaction, :count).by(1)
        expect(response).to redirect_to new_reaction_path
      end
    end


    describe "GET /edit" do
      let(:reaction){create(:reaction, user_id: user.id)}

      it "returns http success" do
        get edit_reaction_path(reaction)

        expect(response.body).to include "添削"
      end
    end

    describe "PATCH /update" do
      let(:reaction){create(:reaction, user_id: user.id)}

      it "renders index" do
        patch reaction_path(reaction), params: {reaction: {content: "change"}}
        expect(flash[:success]).to eq "回答を保存しました。"
        expect(response.body).to include "添削"
      end


    end
  end

  context "ログイン済みでないユーザーの場合" do

    describe "GET /index" do
      it "redirects to login path" do
        get reactions_path
        expect(response).to redirect_to login_path
      end
    end
    #そのほかのアクションについては省略
  end



end
