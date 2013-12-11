class PartidoMailer < ActionMailer::Base
  default from: "noticias@golazzos.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.partido_mailer.partido_termino.subject
  #
  def partido_cerrado(partido, user, bets)
    @partido = partido
    @user = user
    @bets = bets
    mail to: @user.email, subject: "Finalizan las apuestas del partido #{@partido.local} vs #{@partido.visitante}."
  end

  def email_prueba
    mail to: ['brigitteragam@hotmail.com', 'yepes07@gmail.com'] , subject: "Ganaste con Golazzos!  Cúcuta vs Fortaleza."
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
