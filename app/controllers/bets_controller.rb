class BetsController < ApplicationController
	def create
		@partido= Partido.find(params[:partido_id])
		@user = User.find(params[:bet][:user_id])

		if @user.pezzos >= params[:bet][:monto].to_i

			@bet= @partido.bets.create(params[:bet])
			@user.descontar_pezzos(params[:bet][:monto].to_i)
			@user.aumentar_apuestas
			@user.consignar_pezzos(5000)
			flash[:notice] = "Tu marcador fue creado correctamente. Recibes 5000 Pezzos por tu actividad."
			if params[:bet][:posteo_fb]
				mensaje= "Acabo de jugar por el marcador "+@partido.local+" : "+ params[:bet][:golesLocal]+" - "+@partido.visitante+" : "+params[:bet][:golesVisitante]+"\nAdivina el resultado de tus partidos favoritos con Golazzos y gana fabulosos premios."
				@user.aumentar_posts()
				@user.facebook.put_object("me", "feed", :message => mensaje, :picture => 'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-snc7/578495_319362508165730_718918976_n.jpg', :link => 'http://www.golazzos.com/', :name => 'Golazzos', :description => 'Golazzos la nueva Plataforma de apuestas sociales en Futbol.')
  				flash[:notice] = "Gracias por postear en tu muro. Tu marcador fue creado correctamente. Recibes 5000 Pezzos por tu actividad."
			end
			@bet.create_activity :create, owner: current_user
		else
			flash[:notice] = "No tienes suficientes Pezzos para realizar tu juego."
		end
		redirect_to partido_path(@partido)
	end
end
