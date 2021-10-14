# require 'rails_helper'

# RSpec.describe "AccountActivations", type: :request do
#   let(:user) { create(:user, :no_activated) }

#   context "when user sends right token and wrong email" do
#     before do
#       get edit_account_activation_path(
#         user.activation_token,
#         email: 'wrong',
#       )
#     end

#     it "fails login" do
#       expect(is_logged_in?).to be_falsy
#       expect(response).to redirect_to root_url
#     end
#   end

#   context "when user sends wrong token and right email" do
#     before do
#       get edit_account_activation_path(
#         'wrong',
#         emai: user.email,
#       )
#     end

#     it "fails login" do
#       expect(is_logged_in?).to be_falsy
#       expect(response).to redirect_to root_url
#     end
#   end

#   context "when user sends right token and right email" do
#     before do
#      get edit_account_activation_path(
#         user.activation_token,
#         email: user.email,
#       )
#     end


#     it "succeeds login" do
#       expect(is_logged_in?).to be_truthy
#       expect(response).to redirect_to root_path
#     end
#   end
# end
