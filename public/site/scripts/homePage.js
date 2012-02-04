window.application = {};
window.application.searchTerm = {};

//
// Init logic after page 'loading'
//
$(document).ready(function() {
	var template = _.template($("#activityTemplate")[0].text, {data: window.application.activities});
    $("#activitiesContainer").html(template);

});


//
// When the user selects an activity from the first step on the wizard
// the searchTerm object is updated and the wizard moves to the second step.
//
function selectActivity(htmlContainer) {
	id = $(htmlContainer).find("input[type=hidden]").get(0).value;
	window.application.searchTerm.activityId = id;
	right();
}


//
// TODO(rafael.chiti): Remove this. Just for debugging.
//
function alertSearchTerm() {
	alert(JSON.stringify(window.application.searchTerm));
}