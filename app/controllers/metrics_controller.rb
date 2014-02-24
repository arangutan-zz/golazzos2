class MetricsController < ApplicationController
	before_filter :require_admin_login

  def index
    if params[:metric_id]
      @metric = Metrics.find_by_ajax id: params[:metric_id]
    else
      @numeroUsuarios = User.count
      @numeroBets     = Bet.count
    end
  end
end

#@usuarios_que_apostarian            = Profile.where(:apostaria => true).count
#@usuarios_que_apostarian_total      = Profile.where('apostaria  IS NOT NULL').count
#@usuarios_que_apostarian_porcentaje = @usuarios_que_apostarian.to_f / @usuarios_que_apostarian_total.to_f
#@numeroUsuarios                     = User.count
#@numeroBets                         = Bet.count
#@numeroInvitacionesPromedio         = User.average(:invitation_number)
#@numeroUsuariosReferidos            = User.where('invitation_id  IS NOT NULL').count
#@numeroVisitasPromedio              = User.average(:visits_number)
#@numeroPostsPromedio                = User.average(:post_on_fb)
#@tiempoPromedioEnAceptar            = Invitation.average(:demora)
#@usuariosConEdad                    = User.average(:age)
#@numeroApuestasPromedio             = User.average(:bets_number)


#Usuarios Activos
#@usuarios_activos = Metrics.usuarios_activos.sort
#@porcentaje_usuarios_activos_al_mes= Metrics.porcentaje_usuarios_activos_al_mes
#@apuestas_al_mes = Metrics.apuestas_al_mes
#Recurrencia en Meses
#@recurrencia_de_usuarios = Metrics.recurrencia_en_meses.sort

#VIRALIDAD GOLAZZOS 2.0
#@usuariosreferidos = User.sum(:referidos)