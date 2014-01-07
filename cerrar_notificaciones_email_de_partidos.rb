#-----------------------------------
# COMANDO:   rails runner "cerrado.rb"
#-----------------------------------

@yesterday = Time.now - 1.day
@partidos = Partido.where("diapartido < ?", @yesterday)
@partidosCerrados=0
@partidosTerminados=0

@partidos.each do |partido|
	if partido.email_partido_cerrado ==false
		partido.update_attributes email_partido_cerrado: true
		@partidosCerrados+=1
		puts @partidosCerrados
	end

	if partido.email_partido_terminado==false
		partido.update_attributes email_partido_terminado: true
		@partidosTerminados+=1
		puts @partidosTerminados
	end
end
puts "partidos cerrados: #{@partidosCerrados}"
puts "partidosTerminados: #{@partidosTerminados}"
