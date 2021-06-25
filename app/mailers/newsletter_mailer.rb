class NewsletterMailer < ApplicationMailer
  default from: 'example@micolet.com'

  def suscription
    user = params[:user]
    @mujer = user.woman_fashion
    @hombre = user.man_fashion
    @infantil = user.kid_fashion
    mail(to: user.email, subject: '¡Gracias por Suscribirte!')
  end
end
