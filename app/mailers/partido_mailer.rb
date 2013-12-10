class PartidoMailer < ActionMailer::Base
  default from: "golazzos@golazzos.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.partido_mailer.partido_termino.subject
  #
  def partido_cerrado(partido, user, bets)
    @partido = partido
    @user = user
    @bets = bets
    mail to: @user.email, subject: 'Se cerro el partido'
  end

  def email_prueba(user)
    @user = user
    mail to: @user.email , subject: 'Email de prueba'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.partido_mailer.ganadores_del_partido.subject
  #
  def ganadores_del_partido(user, partido)
    @user = user
    @partido = partido
    @greeting = "Hi"

    mail to: "yepes07@gmail.com", subject: 'ganaste en el partido!'
  end
end
