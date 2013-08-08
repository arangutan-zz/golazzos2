class ProfilesController < ApplicationController
	def update
		respond_to do |format|
			if current_user.profile.update_attributes(params[:profile])
				current_user.profile.aumentar_visitas
				if(current_user.profile.num_visitas==1)
					current_user.consignar_pezzos(50000)
					 format.html { redirect_to :back, notice: 'Mi perfil fue actualizado! Ademas obtienes $50,000 por actualizar tu info.' }
		       		 format.json { head :no_content }
		       	else
					 format.html { redirect_to :back, notice: 'Mi perfil fue actualizado!' }
		        	format.json { head :no_content }
				end
		       
		    else
		        format.html { redirect_to :back, alert: 'Te falto llenar algun campo! vuelve a intentarlo' }
		    end
	  	end
		
	end
end
