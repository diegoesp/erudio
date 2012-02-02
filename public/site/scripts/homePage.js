window.application = {};

//
// Init logic after page 'loading'
//
$(document).ready(function() {
	var template = _.template($("#activityTemplate")[0].text, {data: window.application.activities});
    $("#activitiesContainer").html(template);

});


function selectActivity() {
	right();
}

