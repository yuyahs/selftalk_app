require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user){create(:user)}


  describe 'User page' do
    let!(:answer){create(:answer)}
    let!(:reaction){create(:reaction)}

    context "昨日作成されたreactionと今日作成されたanswerが保存されている場合" do

      it "shows reaction and answer records" do
        log_in user
        visit new_answer_path
        fill_in 'textarea1', with: answer.content
        click_button '次の問題へ進む'
        visit new_reaction_path
        fill_in 'textarea2', with: reaction.content
        click_button '次の問題へ進む'
        visit user_path(user)
        expect(page).to have_content "#{answer.created_at.to_date}"
        expect(page).to have_content "#{reaction.created_at.to_date}"
      end

    end
  end
end