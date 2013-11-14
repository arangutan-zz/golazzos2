@yesterday = Time.now - 1.day
@partidos = Partido.where("diapartido < ?", @yesterday)

@partidos.each do |partido|
	if partido.cerrado==false
		partido.update_attributes(cerrado: true)
	end

	if partido.terminado==false
		partido.update_attributes(terminado: true, resultadoLocal: 0 , resultadoVisitante: 0)
	end

	if partido.repartido==false
		partido.repartir_la_plata
		partido.update_attributes(repartido: true)
	end
end