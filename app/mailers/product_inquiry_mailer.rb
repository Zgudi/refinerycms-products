class ProductInquiryMailer < ActionMailer::Base

  def notification(inquiry, request)
    subject     "New Product Inquiry"
    recipients  RefinerySetting.find_or_set(:product_inquiry_recipients, User.first.email)
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    inquiry.email
    sent_on     Time.now
    @inquiry =  inquiry
  end

end