window.application = {};
window.application.searchTerm = {};

checkBoxes = undefined;

// Init logic after page 'loading'
$(document).ready(function() {
	var template = _.template($("#resultTemplate")[0].text, {data: window.application.results});
    $("#resultsColumn").html(template);

	// Load all the checkboxes from the filter section and 
	// synch them with the search term status from the server.
	// TODO(rafael.chiti) This logic should be on the server, changing the 
	// status of the chekboxes after loading the page is not "nice".
	checkBoxes = $("#filterColumn").find("input[type=checkbox]");
	checkBoxes.each(function(index){
		$(this).attr("checked", window.application.searchTerm[this.name]);
	});

});

// Each time the user clicks any of the options from the filter
// this functions is triggered.
function updateBoolFilter(checkBox, filterOption) {
	window.application.searchTerm[filterOption] = checkBox.checked;
}





////////////////////////////////////////////////
//
// 		REMOVE THIS FUNCTIONS WHEN FINISHED
//


// TODO(rafael.chiti): Remove this. Just for debugging.
function alertSearchTerm() {

	alert(JSON.stringify(window.application.searchTerm));
	
}