class PartidoMailer < ActionMailer::Base
  default from: "infogolazzos@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.partido_mailer.partido_termino.subject
  #
  def partido_cerrado
    @greeting = "Hi"

    mail to: "yepes07@gmail.com", subject: "prueba prueba"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.partido_mailer.ganadores_del_partido.subject
  #
  def ganadores_del_partido
    @greeting = "Hi"

    mail to: "yepes07@gmail.com"
  end
end
