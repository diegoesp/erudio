// Initial context for the Result page.
app.result = {};

app.result.searchTerm = {};



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
		url : "result_search?format=json",
		success : function(response) {
			$("#resultsColumn").children().remove();
			var template = _.template($("#resultTemplate")[0].text, {
				data : response
			});
			$("#resultsColumn").append(template);

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