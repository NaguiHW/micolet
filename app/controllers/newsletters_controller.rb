class NewslettersController < ApplicationController
  def index
  end

  def create
    newsletter = Newsletter.new(newsletter_params)
    if params[:woman_fashion] == "0" and params[:man_fashion] == "0" and params[:kid_fashion] == "0"
      flash[:alert] = ['Debe de elegir, aunque sea, una de las preferencias.']
    else
      if newsletter.save
        flash[:notice] = '¡Usted se ha suscrito correctamente para recibir nuestras novedades!'
        NewsletterMailer.with(user: newsletter).suscription.deliver_now
      else
        flash[:alert] = newsletter.errors.full_messages
      end
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def newsletter_params
    params.permit(:email, :woman_fashion, :man_fashion, :kid_fashion)
  end
end
