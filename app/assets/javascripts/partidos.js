$(document).ready(function(){
	$("#botdinero").on("click", function(event){
		event.preventDefault();
		$("#retaramigos").fadeToggle();
		$("#miapuesta").fadeToggle();
	});
	$("#botpezzos").on("click", function(event){
		event.preventDefault();
		$("#retaramigos").fadeToggle();
		$("#miapuesta").fadeToggle();
	});
});