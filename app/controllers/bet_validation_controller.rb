class BetValidationController < ApplicationController
	def index
		#@partido= Partido.first
		@user = User.find(params[:user_id])
	  	respond_to do |format|
		      format.json { render json: @user}
	    	end
	end
end
