$("#spinner").hide();

$(document).ajaxSend(function(r, s) {
$("#spinner").show();});


$(document).ajaxStop(function(r, s) {
$("#spinner").fadeOut("fast");});