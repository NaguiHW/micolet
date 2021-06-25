class NewslettersController < ApplicationController
  require 'net/http'
  require 'net/https'

  def index
  end

  def create
    newsletter = Newsletter.new(newsletter_params)
    response = make_abstract_request(params[:email])
    body = JSON.parse(response.body)

    if params[:woman_fashion] == "0" and params[:man_fashion] == "0" and params[:kid_fashion] == "0"
      flash[:alert] = ['Debe de elegir, aunque sea, una de las preferencias.']
    else
      if body["quality_score"].to_f >= 0.7
        if newsletter.save
          flash[:notice] = '¡Usted se ha suscrito correctamente para recibir nuestras novedades!'
          NewsletterMailer.with(user: newsletter).suscription.deliver_now
        else
          flash[:alert] = newsletter.errors.full_messages
        end
      else
        flash[:alert] = ['El correo que introdujo, no es un correo válido. Intente con otro correo.']
      end
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def newsletter_params
    params.permit(:email, :woman_fashion, :man_fashion, :kid_fashion)
  end

  def make_abstract_request(email)
    uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=f598e161d56f4cdd9ff058bf7db78acf&email=#{email}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request =  Net::HTTP::Get.new(uri)

    response = http.request(request)
  end
end
