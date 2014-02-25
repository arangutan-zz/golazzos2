//---------------------------------------------------------------------------
// FUNCIONES
//---------------------------------------------------------------------------



function actualizarRetornos(){
	var local = +$(".marcadorlocal").val();
	var visitante = +$(".marcadorvisitante").val();
	var monto = $("#bet_monto").val();
	var totalApostado = + $("#bets-info").data("total");
	var minimoTotal = + $("#bets-info").data("minimototal");
	var veces = $(".local"+local+"visitante"+visitante).data(monto);
	var retornoEstimado = veces *monto;
	var retornoMinimo = monto*2;

	if(retornoEstimado < retornoMinimo && totalApostado <= minimoTotal){
		retornoEstimado = "Por definir";
	}

	if (retornoEstimado < retornoMinimo && totalApostado > minimoTotal) {
		$("#marcadorAbierto").hide();
		$("#marcadorBloqueado").show();
		$("input#jugarPezzos").hide();
	}
	else
	{
		$("#marcadorBloqueado").hide();
		$("#marcadorAbierto").show();
		$("input#jugarPezzos").show();
		$("#retornoEstimado").text(retornoEstimado);
		$("#retornoMinimoGarantizado").text(retornoMinimo);
	}
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

function verificarMarcadores(){
	var local = $(".marcadorlocal").val();
	var visitante = $(".marcadorvisitante").val();

	if(local===""){
		$(".marcadorlocal").val(0);
	}
	if(visitante===""){
		$(".marcadorvisitante").val(0);
	}
}
function compartirEnFacebook(){
	$("form#new_bet").submit(function(){
		var compartir = confirm("¿Deseas compartir tu apuesta con tus amigos en Facebook? Recibes 20,000 pezzos por compartir.");
		if(compartir===true)
		{
			$("form#new_bet").prepend('<input id="bet_posteo_fb" name="bet[posteo_fb]" type="hidden" value="true">');
		}
	});

}

//function validarApuesta(){
	//var url="/bet_validation/index";
	//var data= "user_id="+$("input#bet_user_id").val() + "?";
	//$.ajax({
	  //dataType: "json",
	  //url: url,
	  //data: data,
	  //success: function(response){
	  //	console.log(response);
	  //},
	  //beforeSend: function(){
	  //	console.log("enviando: " + data );
	  //}
	//});
//}

//---------------------------------------------------------------------------
// DOCUMENT READY
//---------------------------------------------------------------------------
$(document).ready(function(){

	//ACTUALIZAR RETORNOS EN LA [APUESTA]
	actualizarRetornos();
	$(".marcadoruser1").on("change",actualizarRetornos) //.on("change",validarApuesta);
	$("#bet_monto").on("change", actualizarRetornos)      //.on("change",validarApuesta);

	$("#jugarPezzos").on("click", verificarMarcadores).on("click", compartirEnFacebook);

	//CATEGORIZAR LOS PARTIDOS POR TORNEOS EN [PARTIDOS]
	$("#torneoSelector").on("change", categorizarPartidos);
});