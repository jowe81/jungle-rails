# Preview all emails at http://localhost:3000/rails/mailers/user
class UserMailerPreview < ActionMailer::Preview
  def order_confirmation
    order = Order.find(13)
    user = User.find_by_email(order.email)
    UserMailer.order_confirmation(user, order)
  end
end
