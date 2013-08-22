$(document).ready(function(){
	$("#botperfil").on("click", function(event){
		event.preventDefault();
		$("#perfiluser").fadeToggle();
		$("#navmenu").hide();
	});
	$("#nav").on("click", function(event){
		event.preventDefault();
		$("#navmenu").fadeToggle();
		$("#perfiluser").hide();
	});

});