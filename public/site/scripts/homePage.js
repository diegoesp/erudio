window.application = {};

//
// Init logic after page 'loading'
//
$(document).ready(function() {
	activities = window.application.activities;
	$( "#activityTemplate" ).tmpl().appendTo( "#slideBox1" );
});
