require 'rails_helper'

RSpec.describe "Answers", type: :request do

  let(:user){create(:user)}

  before do
    log_in_as user
    questions = create_list(:question, 10)
  end

  describe "GET /index" do
    it "returns http success" do
      get answers_path
      expect(response).to have_http_status "200"
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_answer_path
      expect(response).to have_http_status "200"
    end
  end

  describe "POST /create" do
    let(:question){create(:question)}
    it "redirects to new" do
      post answers_path, params: {id: question.id, answer: {content: "test"}}
      expect(response).to redirect_to new_answer_path
    end
  end


  describe "GET /edit" do
    let(:answer){create(:answer, user_id: user.id)}

    it "returns http success" do
      get edit_answer_path(answer)

      expect(response).to have_http_status "200"
    end
  end

  describe "PATCH /update" do
    let(:answer){create(:answer, user_id: user.id)}

    it "redirects to index" do
      patch answer_path(answer), params: {answer: {content: "change"}}
      expect(response).to redirect_to answers_path
    end


  end



end
