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

$(document).on('touchstart.dropdown.data-api', '.dropdown-menu', function (e) { e.stopPropagation() });