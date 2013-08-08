class InvitationsController < ApplicationController
  before_filter :require_login
  def new
    @invitation = Invitation.new
    @user = current_user
    @linkwallpost= "https://www.facebook.com/dialog/feed?
  app_id=193467880799348&
  link=https://www.golazzos.com/&
  name=Visita%20Golazzos%20y%20gana%20premios&
  caption=La%20nueva%20plataforma%20de%20apuestas%20sociales%20en%20futbol&
  description=.&
  redirect_uri=http://www.golazzos.com/"

  end

  def create
    

#@linkinvitation= "http://www.facebook.com/dialog/send?app_id=116412671734664&link=http://developers.facebook.com/docs/reference/dialogs/&redirect_uri=http://www.jetsetter.com/&to=100000910418225,590528674"

        #@linkinvitation= "http://www.facebook.com/dialog/send?app_id=193467880799348&
#name=Te%20invito%20a%20que%20juegues%20conmigo%20en%20Golazzos,%20el%20juego%20divertido%20de%20futbol%20y%20gana%20fabulosos%20premios&
#link=http://www.golazzos.com/home/"+current_user.uid+"/&
#redirect_uri=http://www.golazzos.com/invitations/new"
    
    #@linkinvitation= "https://www.facebook.com/dialog/apprequests?
  #app_id=193467880799348&
  #message=Visita%20Golazzos%20y%20gana%20premios%20como%20boletas%20camisetas%20y%20balones%20cada%20mes&to="+@invitados.to_s+"&redirect_uri=http://www.golazzos.com/invitations/new"
@friends = current_user.facebook.get_connections("me", "friends?fields=id,name,picture.type(square)")
 @linkinvitation= "http://www.golazzos.com/home/#{current_user.uid}"
 

    #redirect_to root_url, :notice => @mensaje
    render :msg, :notice => "Tu solicitud ha sido creada exitosamente."  

  end
  #termino create

end
