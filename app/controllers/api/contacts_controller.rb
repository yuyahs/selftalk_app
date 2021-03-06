class Api::ContactsController < ApplicationController

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      response_success(:inquiry, :create)
    else
      response_bad_request
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :message)
  end
end
