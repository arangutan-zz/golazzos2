class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    @user.aumentar_visitas
    session[:user_id] = @user.id
    #ADDED
    #Aqui se guarda el token de acceso que se necesita para todas las operaciones.
    session['fb_access_token'] = @user.oauth_token
    ##############
    if@user.visits_number==1
      @user.consignar_pezzos(100000)
      
      #revisa referido
      #@invitacion= Invitation.find_by_token(session['guacamaya'])
      @anfitrion= User.find_by_uid(session['guacamaya'])

       #@invitacion= Invitation.find_by_recipient_uid(@user.uid)
      if @anfitrion==nil #No es referido
        flash[:notice] = "Recibes 100.000 Pezzos por tu primera visita"
      else
        #if @invitacion.recipient_uid == @user.uid
        if @user.uid == @user.uid
                    
          #@user.update_attributes(invitation_id: @invitacion.id)
          #@invitacion.update_attribute(:used, "true")
          #@invitacion.actualizar_demora
          if true
            flash[:notice] = "Recibes 50.000 Pezzos por tu primera visita. Recibiste 50.000 Pezzos extra gracias a que tu amigo te invito"  
            @user.consignar_pezzos(50000)
            #Le doy Pezzos al que me refirio.
            
            @anfitrion.consignar_pezzos(50000)
            @anfitrion.aumentar_referidos
            
            #Asigno la invitacion al usuario si fue invitado
            @user.update_attributes(invitation_id: @anfitrion.id)
          else 
            #flash[:notice] = "Recibes 20.000 Pezzos por tu primera visita. Recibiste 50.000 Pezzos extra gracias a que tu amigo te invito"  
            #@user.consignar_pezzos(20000)
            #Le doy Pezzos al que me refirio.
            #id_anfitrion=@invitacion.sender_id
            #@usuario_anfitrion= User.find_by_id(id_anfitrion).consignar_pezzos(20000)
            #Asigno la invitacion al usuario si fue invitado
           
          end 

#          @demoraT=(Time.now - @invitacion.created_at.to_time)/1.day
 #         @invitacion.update_attributes(:demora, @demoraT)
        else
          flash[:notice] = "Solo recibes 50.000 Pezzos por tu primera visita, la invitacion no era para ti."  
        end

      end      
      #grrrrrr ----
      redirect_to user_path(@user, :nuevousuario=>"true")
      return
    end
    begin
      redirect_to :back
      return
    rescue
      #redirect_to partidos_path, notice: "¡LO SENTIMOS! Vuelve a buscar el partido."
      redirect_to current_user
      return
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end

