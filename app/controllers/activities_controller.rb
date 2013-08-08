class ActivitiesController < ApplicationController
  before_filter :require_login
  def index
  	following_ids = current_user.following_ids
  	following_ids.push(1)
  	#@activities =PublicActivity::Activity.paginate(page: params[:page], per_page: 5).order("created_at desc")
  	@activities =PublicActivity::Activity.paginate(page: params[:page], per_page: 7).order("created_at desc").where(owner_id: following_ids, owner_type: "User")

  	@following= current_user.following
  	@followers= current_user.followers

  	@hora = Time.now - 1.day
  	@partidos = Partido.where("diapartido > ?", @hora).order("diapartido ASC")
    
    @ranking = @following
    @ranking.push(current_user)
    @ranking_followers=@ranking.sort_by { |e| -e[:pezzos]}
  end
end
