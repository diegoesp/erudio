window.application = {};
window.application.searchTerm = {};

//
// Init logic after page 'loading'
//
$(document).ready(function() {
	var template = _.template($("#activityTemplate")[0].text, {data: window.application.activities});
    $("#activitiesContainer").html(template);

});


// When the user selects an activity from the first step on the wizard
// the searchTerm object is updated and the wizard moves to the second step.
function selectActivity(htmlContainer) {
	id = $(htmlContainer).find("input[type=hidden]").get(0).value;
	window.application.searchTerm.activityId = id;
	right();
}


// TODO(rafael.chiti): Remove this. Just for debugging.
function alertSearchTerm() {
	alert(JSON.stringify(window.application.searchTerm));
}


// TODO(rafael.chiti): Remove this. Just for debugging.
function postSearch() {
	jqxhr = $.ajax({
		type: 'POST',
		url: 'http://localhost:3000/pages/testPage/home',
		data: window.application.searchTerm,
		success: 'postSearchSuccessCB',
		dataType: 'json'
	});
	//jqxhr.error = "postSearchFailCB";
	
}


// TODO(rafael.chiti): Remove this. Just for debuggin (the call back function for the ajax call).
function postSearchSuccessCB(data, textStatus, jqXHR) {
	alert("response succeed");
}
// TODO(rafael.chiti): Remove this. Just for debuggin (the call back function for the ajax call).
function postSearchFailCB() {
	alert("request failed");
}



