class UsersController < ApplicationController
  before_filter :require_login

  def index
    @users= User.paginate(page: params[:page], per_page: 15).order("pezzos DESC")
    if params[:page]==nil
      @page = 1
    else
      @page = ((params[:page].to_i - 1) * 15) + 1  
    end

  end

  def show
    #Golazzos 1
    @user= User.find(params[:id])
    #if @user.profile ==nil
    #  @user.profile =Profile.new
    #end

    #if @user.partidos.any?
      #if params[:partidoId]
       # @partido= Partido.find(params[:partidoId])
      #else
       # @partido = @user.partidos.first
      #end

      #@bets= @partido.bets.where("user_id = ?", @user.id) 
    #end   
    #@pezzos_por_amigos= User.where('invitation_id = ?', @user.id).count * 50000
    #@pezzos_por_amigos= @user.referidos * 5000
    #@pezzos_por_actividad= @user.bets.count * 5000


    #golazzos2.0
    #@friends= @user.following


    @partidos = @user.partidos.order("diapartido DESC")

    @followings = [@user.id]
    if @user !=current_user
      @followings = @followings + current_user.following_ids
      @followings = @followings.uniq
    end

    #@bets = Bet.limit(10).find(:all, conditions: { user_id: @followings}, order: "created_at DESC")
    @bets = Bet.limit(10).where(user_id:@followings).order("created_at DESC")
    @ranking =@user.following
    @ranking.push(@user)
    #@friends = @ranking.sort_by! {|u| u.pezzos_acumulados}
    @friends = @ranking.sort { |x,y| y.pezzos_acumulados <=> x.pezzos_acumulados }
  end

  def update
  	current_user.update_attributes(params[:user])
    @partido = Partido.find(params[:partido_actual_id])
    respond_to do |format|
      format.html { redirect_to :back}
      format.js
    end
  end

end