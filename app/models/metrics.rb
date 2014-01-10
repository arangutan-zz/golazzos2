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

	def self.porcentaje_usuarios_activos_al_mes
		retorno={}
		bets= Bet.includes(:user).all
		bets_grouped_by_month = bets.group_by { |bet| bet.created_at.beginning_of_month}
		bets_months =  bets_grouped_by_month.keys.sort
		bets_months.each_index do | i | 
			actual = bets_months[i]
			siguiente = bets_months[i+1]
			siguiente = Date.today unless siguiente
			users_de_ese_mes = User.includes(:bets).where( "? < bets.created_at and bets.created_at  < ?", actual, siguiente )
			retorno[actual] = users_de_ese_mes.count
		end

		return retorno

		#users = User.joins(:bets).where( bets: { created_at: bets_months.first } ).uniq.inspect

	end

	def self.recurrencia_en_meses
		users = User.includes(:bets).all
		retorno={}

		users.each do |user|
			grouped_bets_by_month = user.bets.group_by { |bet| bet.created_at.beginning_of_month } 
			months_betted = grouped_bets_by_month.keys.count

			if retorno[months_betted]==nil
				retorno[months_betted]=1
			else
				retorno[months_betted]+=1
			end
		end
		return retorno
	end

end
