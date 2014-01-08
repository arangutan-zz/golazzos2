class Metrics < ActiveRecord::Base
  attr_accessible :apuestas_usuario, :login_usuario, :posts_usuario, :referidos_usuario, :sinapostar_usuarios, :sininvitar_usuarios, :total_apuestas, :total_referidos, :total_usuarios

	def self.usuarios_activos
		users= User.includes(:bets).all
		retorno={}

		users.each do |user|
			numApuestas = user.bets.count
			if retorno[numApuestas]==nil
				retorno[numApuestas]=1
			else
				retorno[numApuestas]+=1
			end
		end
		
		#Retorna { numApuestas => numUsers }
		return retorno
	end  
end
