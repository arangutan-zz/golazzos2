class MetricsController < ApplicationController
	before_filter :require_admin_login

  def index
    @usuarios_que_apostarian = Profile.where(:apostaria => true).count
    @usuarios_que_apostarian_total = Profile.where('apostaria  IS NOT NULL').count

    @usuarios_que_apostarian_porcentaje = @usuarios_que_apostarian.to_f / @usuarios_que_apostarian_total.to_f
  end
  
  def emails
		#@users = User.all
  end
  
  def estampas
  	  #Crea cada registro...
      @registro = Metrics.new()
      
      @registro.total_usuarios=User.count
	    @registro.total_apuestas=Bet.all.count
	  @registro.apuestas_usuario=User.average(:bets_number)
	  @registro.total_referidos=User.where('invitation_id  IS NOT NULL').count
	  @registro.referidos_usuario=User.average(:referidos)
	  @registro.login_usuario=User.average(:visits_number)
	  @registro.posts_usuario=User.average(:post_on_fb)
	  @registro.sinapostar_usuarios=User.where(:bets_number =>0).count


	  
      if @registro.save
        #algo sucede...
      end
  end
end
