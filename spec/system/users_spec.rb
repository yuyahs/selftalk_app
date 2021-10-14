# require 'rails_helper'

# RSpec.describe User, type: :system do
#   let(:user){create(:user)}

#   describe 'User page' do
#     let!(:question){create(:question, :mode_2)}
#     let!(:answer){create(:answer)}



#     it "shows answer records" do
#       log_in user
#       visit new_answer_path(mode_num: 2)
#       fill_in 'textarea1', with: answer.content
#       click_button '次の問題へ進む'
#       visit user_path(user)
#       expect(page).to have_content "#{answer.created_at.to_date}"
#       expect(page).to have_content "1日"

#     end
#   end


# end
