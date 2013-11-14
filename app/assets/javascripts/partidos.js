function actualizarRetornos(){
	var local = $(".marcadorlocal").val();
	var visitante = $(".marcadorvisitante").val();
	var monto = $("#bet_monto").val();
	var veces = $(".local"+local+"visitante"+visitante).data(monto);
	var retornoEstimado = veces *monto;
	var retornoMinimo = monto*2;
	
	if (retornoEstimado < retornoMinimo) 
	{
		retornoEstimado = "por definir";
	}

	$("#retornoEstimado").text(retornoEstimado);
	$("#retornoMinimoGarantizado").text(retornoMinimo);
}

function categorizarPartidos(){
	var torneo = $("#torneoSelector").val();
	var partidos = $(".partido");
	var partidosTorneo = $(".partido.torneo"+torneo);
	
	if (torneo==0) {
		partidos.show();
	}
	else{
		partidos.hide();
		partidosTorneo.show();
	}

}

$(document).ready(function(){
	$(".marcadoruser1").on("change",actualizarRetornos);
	$("#bet_monto").on("change", actualizarRetornos);
	$("#torneoSelector").on("change", categorizarPartidos);

	$(".linkreglasGolazzos").on("click", function(event){
		event.preventDefault();
		$(".reglasGolazzos").fadeToggle();
	});

	$("input[name=agree]").on("change", function(){
		$(".botonfacebook").show();
		$(".terminosycondiciones").hide();
	});

	$("input[name=dinero]").on("click", function(){
		alert("Todavia no hemos lanzado la version paga de Golazzos. PROXIMAMENTE. :)");
	});
});