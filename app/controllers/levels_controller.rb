class LevelsController < ApplicationController
	def index
		@level  = Level.new
		@levels = Level.all
	end
	def create
		@level = Level.new params[:level]
		if @level.save
			redirect_to levels_path, notice: "Se creo el Nivel exitosamente."
		else
			redirect_to levels_path, error: "No se pudo crear el Nivel."
		end
	end
	def destroy
		@level = Level.find params[:id]
		@level.destroy
		redirect_to levels_path, notice: "El nivel se elimino correctamente."
	end
end
