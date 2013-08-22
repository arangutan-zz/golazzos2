class PartidosController < ApplicationController
  # GET /partidos
  # GET /partidos.json
  before_filter :require_login, except: [:index, :mostrar]
  before_filter :require_admin_login , :only => [:new, :edit, :update, :destroy, :create, :repartir]
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

    #amigos a favor y en contra.
    @partido = Partido.find(params[:id])
    
    @supporters=@partido.supporters_partido(current_user.following,@partido)
    @linkinvitation= "http://www.facebook.com/dialog/feed?app_id=193467880799348&
name=Los%20invito%20a%20que%20jueguen%20conmigo%20en%20Golazzos,%20En%20el%20partido%20de%20#{@partido.local}%20vs.%20#{@partido.visitante}&
link=http://www.golazzos.com/partidos/#{@partido.id}&
redirect_uri=http://www.golazzos.com/partidos/#{@partido.id}"
      
    if @partido.repartido
      @ganadores = @partido.ganadores_del_partido
      @ranking_followers = @ganadores
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partido }
    end    
  end

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

    respond_to do |format|
      if @partido.update_attributes(params[:partido])
        if (@partido.terminado && @partido.cerrado)
          @partido.create_activity :termino, owner: current_user
        else
          @partido.create_activity :update, owner: current_user
        end
        format.html { redirect_to @partido, notice: 'Partido was successfully updated.' }
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

  end
end
