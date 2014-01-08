users= User.includes(:bets).all

users.each do |user|
	numApuestas = user.bets.count
	if numApuestas>50
		puts user.name
	end
end

#Retorna { numApuestas => numUsers }
return retorno