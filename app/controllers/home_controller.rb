class HomeController < ApplicationController
  def index
    @partido= Partido.where("diapartido > ?", Time.now).order("diapartido ASC").first
    #track_ga_event("Users", "Login", "Standard")
    #@partido = Partido.find(64)
  end
  def index2
  end
  def reglamento
    
  end
  def contacto
    
  end

  def invitacion
    @mensaje = params[:mensaje]
    @fbUser = params[:fbUser]
    current_user.facebook.put_wall_post("prueba prueba golazzos @antonio.faillace.96", {tag: "antonio.faillace.96"}) 
  end

  def referido
  		
    #Revisa si esta invitado o no esta invitado para mostrar un mensaje.  
  	
    @invitacion= User.find_by_uid(params[:invitation_token])
    session[:guacamaya]=params[:invitation_token]

    if @invitacion==nil
      #flash[:notice] = "Invitación no válida"  
    else
      flash[:notice] = "Has sido invitado a Golazzos, registrate y redime 50.000 Pezzos gratis!"  
    end

  end
end
