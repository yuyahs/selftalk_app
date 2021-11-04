class InquiryMailer < ApplicationMailer
  # -----追記------
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: 'system@example.com',
      to:   'selftalk.english@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
# -----追記ここまで----
end
