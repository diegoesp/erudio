// Initial context for the Result page.
app.result = {};

app.result.searchTerm = {};

//
// Initialization (called on DOM ready)
//
app.result.initialize = function() {
	// Initialize the SweetCheckboxes by calling the config method from the
	// library
	configureSweetCheckboxes();

	// Bind the "results" JSON object to the template and render it.
	var template = _.template($("#resultTemplate")[0].text, {
		data : app.result.results
	});
	$("section#results").append(template);

	// Load all the checkboxes from the filter section and
	// synch them with the search term status from the server.
	// TODO(rafael.chiti) This logic should be on the server, changing the
	// status of the chekboxes after loading the page is not "nice".
	$(".sweetCheckbox").each(function(index) {
		if (app.result.searchTerm[this.title] === true) {
			$(this).trigger('turnOn');
		}
	});

	// Configure the ToolTipsy tool.
	app.result.initializeTooltipsy();
}

// Update the searchTerm JSON object based on the state of the 'clicked'
// checkbox.
// Each time the user clicks any of the options from the filter
// this functions is triggered.
app.result.updateBoolFilter = function(checkBox, filterOption) {
	app.result.searchTerm[filterOption] = !$(checkBox).triggerHandler(
			'isOn');
	app.result.executeAjaxSearch();
}

app.result.executeAjaxSearch = function() {
	$.ajax({
		url : "/result_search?format=json",
		success : function(response) {
			$("section#results").children().remove();
			var template = _.template($("#resultTemplate")[0].text, {
				data : response
			});
			$("section#results").append(template);

		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

// Initialize and configure the tooltips for this page (tooltipsy library)
app.result.initializeTooltipsy = function() {
	$('.hasTooltipsy').tooltipsy({
		offset : [ -10, 0 ],
		css : {
			'padding' : '10px',
			'max-width' : '200px',
			'color' : '#303030',
			'background-color' : '#f5f5b5',
			'border' : '1px solid #deca7e',
			'-moz-box-shadow' : '0 0 10px rgba(0, 0, 0, .5)',
			'-webkit-box-shadow' : '0 0 10px rgba(0, 0, 0, .5)',
			'box-shadow' : '0 0 10px rgba(0, 0, 0, .5)',
			'text-shadow' : 'none'
		}
	});
}

// ////////////////////////////////////////////////////////////
//
// REMOVE THIS FUNCTIONS WHEN FINISHED (DEBBUGING BOX)
//
// ////////////////////////////////////////////////////////////

// TODO(rafael.chiti): Remove this. Just for debugging.
app.result.alertSearchTerm = function() {

	alert(JSON.stringify(app.result.searchTerm));
}