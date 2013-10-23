class PartidosController < ApplicationController
  # GET /partidos
  # GET /partidos.json
  before_filter :require_login, except: [:index,:show]
  before_filter :require_admin_login , :only => [:new,:edit,:update,:destroy,:create,:repartir]

  def index
  	@hora = Time.now - 1.day
  	@partidos = Partido.where("diapartido > ?", @hora ).order("diapartido ASC")

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partidos }
    end
  end

  # GET /partidos/1
  # GET /partidos/1.json
  def show
  	@partido = Partido.includes(:bets).find(params[:id])


    #--REDIRECCIONAMIENTO BEGINS----
    #redirecciona al ESTADIO si el partido ya esta cerrado
    if @partido.cerrado
      redirect_to estadio_partido_path @partido 
      return
    #-- Si el Usuario ya aposto en el partido, ir al estadio directamente
    elsif current_user and current_user.partidos.include?(@partido) and params[:ir_estadio]
      redirect_to estadio_partido_path @partido
      return
    elsif current_user and !current_user.partidos.include?(@partido) and @partido.cerrado
        redirect_to resultado_partido_path @partido
    end
    #--REDIRECCIONAMIENTO ENDS----

    #-- PARAMS del RETO BEGINS --
    if params[:betid] and params[:userid]
      @bet = Bet.find(params[:betid])
      @user = User.find(params[:userid])
      if current_user
        frien = Friendship.where("friend_id = ? AND user_id = ?", @user.id, current_user.id)
        if !frien.empty? || (@user.id == current_user.id)
            #la amistad ya existe!!!
            current_user.consignar_pezzos(25000)
            @user.consignar_pezzos(25000)
            flash[:notice]= "la amistad ya existe! Se les consignaron $25,000 pezzos en sus cuentas por retarse!"
        else
            @friendship = current_user.friendships.build( friend_id: @user.id)
            @friendshipDos = @user.friendships.build(friend_id: current_user.id)
            if @friendship.save && @friendshipDos.save
              #se les dan 50,000 pezzos por la nueva amistad
              current_user.consignar_pezzos(50000)
              @user.consignar_pezzos(50000)
              #se creo la amistad exitosamente
              flash[:notice]= "Se creo la amistad Correctamente. Se les consignaron $50,000 pezzos en sus cuentas :)."
            end
        end
      end

    end
    #-- PARAMS del RETO ENDS --

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partido }
    end    
  end

  def retar
    @partido = Partido.find(params[:id])

    #redirecciona al ESTADIO si el partido ya esta cerrado
    if @partido.cerrado
      redirect_to estadio_partido_path(@partido)
      return
    end

    @bet = Bet.find(params[:betid])
    @linkinvitation = partido_url(@partido).to_s+"?userid=#{current_user.id}&betid=#{@bet.id}"
    @friends = current_user.facebook.get_connections("me", "friends?fields=id,name,picture.type(square)")
  end

  def estadio
    @partido = Partido.find(params[:id])

    #SI el partido ya TERMINO y se REPARTIO la plata. Redireccionar al Resultado
    if @partido.repartido
      redirect_to resultado_partido_path(@partido)
      return
    end

    @bet= current_user.bets.order("created_at DESC").find_by_partido_id(@partido.id)
    @bets = Bet.find(:all, conditions:{ partido_id:@partido.id, user_id:current_user.following_ids})
    @friends_in_bet = @bets.uniq {|x| x.user_id}
    @friends = current_user.following
  end

  def resultado
    @partido = Partido.find(params[:id])

    #Redirecciona al SHOW si el aprtido no ha empezado. Todavia se pueden hacer apuestas
    if !@partido.cerrado
      redirect_to partido_path( @partido)
      return
      #SI EL PARTIDO se cerro pero no se ha repartido la plata, redireccionar al ESTADIO.
    elsif !@partido.repartido
      redirect_to estadio_partido_path(@partido)
      return
    end
      
    @bet = current_user.bets.order("created_at DESC").find_by_partido_id(@partido.id)
    @bets = Bet.find(:all, conditions: { partido_id: @partido.id, user_id: current_user.following_ids})
    @friends = current_user.following
  end




#------------------------------------------
# NEW _ EDIT _ CREATE _UPDATE _ DESTROY
#------------------------------------------



  # GET /partidos/new
  # GET /partidos/new.json
  def new
  	@partido = Partido.new

  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partido }
    end
  end

  # GET /partidos/1/edit
  def edit
  	@partido = Partido.find(params[:id])
  end

  # POST /partidos
  # POST /partidos.json
  def create
  	@partido = Partido.new(params[:partido])

  	respond_to do |format|
  		if @partido.save
  			@partido.create_activity :create, owner: current_user
  			format.html { redirect_to @partido, notice: 'Partido was successfully created.' }
  			format.json { render json: @partido, status: :created, location: @partido }
  		else
  			format.html { render action: "new" }
  			format.json { render json: @partido.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # PUT /partidos/1
  # PUT /partidos/1.json
  def update
  	@partido = Partido.find(params[:id])
    
    #prueba
    #PartidoMailer.partido_cerrado.deliver

    #si el partido se acaba de cerrar enviar email 
    if @partido.cerrado && !@partido.terminado && !@partido.repartido
      #@partido.enviar_email_se_cerro_el_partido
      #flash[:notice] = "se envio el email"
    end

  	respond_to do |format|
  		if @partido.update_attributes(params[:partido])
  			if (@partido.terminado && @partido.cerrado)
  				@partido.create_activity :termino, owner: current_user
  			else
  				@partido.create_activity :update, owner: current_user
  			end
  			format.html { redirect_to edit_partido_path @partido, notice: 'Partido was successfully updated.' }
  			format.json { head :no_content }
  		else
  			format.html { render action: "edit" }
  			format.json { render json: @partido.errors, status: :unprocessable_entity }
  		end
  	end
  end

	# DELETE /partidos/1
	# DELETE /partidos/1.json
	def destroy
		@partido = Partido.find(params[:id])
		@partido.destroy

		respond_to do |format|
			format.html { redirect_to partidos_url }
			format.json { head :no_content }
		end
	end

	def repartir
		@partido = Partido.find(params[:id])
		if @partido.terminado && @partido.cerrado
			@partido.repartir_la_plata
			@partido.update_attributes(repartido: true)
			redirect_to partido_path(@partido), notice: "Se repartio la plata !"
		else
			redirect_to edit_partido_path(@partido), notice: "Asegurate de Cerrar la apuesta y de agregar el marcador"
		end
	end

	def mostrar
    @partidos = Partido.all
	end




end
