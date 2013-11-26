class BetsController < ApplicationController
	def create
		@partido= Partido.find(params[:partido_id])
		@user = User.find(params[:bet][:user_id])

		if  !@partido.puedo_apostar_en_el_marcador?(params[:bet][:golesLocal].to_i,params[:bet][:golesVisitante].to_i,params[:bet][:monto].to_i)
			redirect_to partido_path(@partido, notice: "No puedes jugar por el marcador #{params[:bet][:golesLocal]}-params[:bet][:golesVisitante], se encuentra muy lleno y no garantiza retorno.")
			return
		end

		if @user.pezzos >= params[:bet][:monto].to_i

			@bet= @partido.bets.create(params[:bet])
			@user.descontar_pezzos(params[:bet][:monto].to_i)
			@user.aumentar_apuestas
			@user.consignar_pezzos(10000)
			flash[:notice] = "Tu marcador fue creado correctamente. Recibes 10000 Pezzos por tu actividad."
			if params[:bet][:posteo_fb]
				mensaje= "Acabo de jugar por el marcador: "+@partido.local+" "+ params[:bet][:golesLocal]+" - "+params[:bet][:golesVisitante]+" "+@partido.visitante
				@user.aumentar_posts()
				@user.consignar_pezzos(10000)
				@user.facebook.put_object("me", "feed", :message => mensaje, :picture => 'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-snc7/578495_319362508165730_718918976_n.jpg', :link => 'http://www.golazzos.com/partidos/#{@partido.id}', :name => 'Golazzos', :description => 'La plataforma de apuestas sociales en Futbol. Reta a tus amigos, apuesta con ellos, y demuestra quien sabe mas de futbol.')
  				flash[:notice] = "Gracias por postear en tu muro. Tu marcador fue creado correctamente. Recibes 20000 Pezzos por tu actividad."
			end
			@bet.create_activity :create, owner: current_user
		else
			redirect_to partido_path(@partido, notice: "No tienes suficientes Pezzos para realizar la apuesta!")
		end
		redirect_to retar_partido_path(@partido, betid: @bet.id)
	end
end
