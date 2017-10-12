class UserMailer < ApplicationMailer
    default from: 'no-reply@jungle.com'

    def order_email(email, order)
        @order = order
        mail(to: email, subject: "Your order ##{order.id}")
    end
end
