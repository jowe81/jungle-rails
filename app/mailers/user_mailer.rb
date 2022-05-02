class UserMailer < ApplicationMailer
  default from: 'customer-service@jungle-shop.com'

  def order_confirmation user, order
    @rcpt = "johannes@drweber.de"
    @order = order
    if user != nil
      @rcpt = user.email
    end  
    mail(to: @rcpt, subject: 'Your order from Jungle is confirmed')
  end
end
