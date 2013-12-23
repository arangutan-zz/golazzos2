class PartidoMailer < ActionMailer::Base
  default from: "notificaciones@golazzos.com"

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
    mail to: ['brigitteragam@hotmail.com', 'yepes07@gmail.com'] , subject: "Ganaste con Golazzos!  Cucuta vs Fortaleza."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.partido_mailer.ganadores_del_partido.subject
  #
  def ganador_del_partido(partido, user, bets)
    @user = user
    @partido = partido
    @bets = bets

    mail to: @user.email, subject: "Ganaste con Golazzos! #{@partido.local} vs #{@partido.visitante}."
  end

    def perdedor_del_partido(partido, user, bets)
    @user = user
    @partido = partido
    @bets = bets

    mail to: @user.email, subject: "Sigue intentando con Golazzos! #{@partido.local} vs #{@partido.visitante}."
  end

  def email_apuesta_realizada(user, bet)
    @user = user
    @bet = bet
    @partido = bet.partido

    mail to: @user.email, subject: "Confirmamos tu apuesta al partido #{@partido.local} vs #{@partido.visitante}."
  end

end
