window.application = {};
window.application.searchTerm = {};

//
// DOCUMENT READY
//
// Init logic after page 'loading'
//
$(document).ready(function() {
	
	// Initialize the SweetCheckboxes by calling the config method from the library
	configureSweetCheckboxes();

	// Bind the "results" JSON object to the template and render it.
	var template = _.template($("#resultTemplate")[0].text, {data: window.application.results});
    $("#resultsColumn").append(template);

	// Load all the checkboxes from the filter section and 
	// synch them with the search term status from the server.
	// TODO(rafael.chiti) This logic should be on the server, changing the 
	// status of the chekboxes after loading the page is not "nice".
	$(".sweetCheckbox").each(function(index){
		if (window.application.searchTerm[this.title] === true) {
			$(this).trigger('turnOn');		
		} 
	});

	// Configure the ToolTipsy tool.
	initializeTooltipsy();

});

// Update the searchTerm JSON object based on the state of the 'clicked' checkbox.
// Each time the user clicks any of the options from the filter
// this functions is triggered.
function updateBoolFilter(checkBox, filterOption) {
	window.application.searchTerm[filterOption] = !$(checkBox).triggerHandler('isOn');
}


// Initialize and configure the tooltips for this page (tooltipsy library)
function initializeTooltipsy() {
	$('.hasTooltipsy').tooltipsy({
	    offset: [-10, 0],
	    css: {
	        'padding': '10px',
	        'max-width': '200px',
	        'color': '#303030',
	        'background-color': '#f5f5b5',
	        'border': '1px solid #deca7e',
	        '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
	        '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
	        'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
	        'text-shadow': 'none'
	    }
	});
}


//////////////////////////////////////////////////////////////
//
// 	REMOVE THIS FUNCTIONS WHEN FINISHED (DEBBUGING BOX)
//
//////////////////////////////////////////////////////////////

// TODO(rafael.chiti): Remove this. Just for debugging.
function alertSearchTerm() {

	alert(JSON.stringify(window.application.searchTerm));
}