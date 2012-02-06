window.application = {};
window.application.searchTerm = {};

checkBoxes = undefined;

// Init logic after page 'loading'
$(document).ready(function() {
	
	configureSweetCheckboxes();

	var template = _.template($("#resultTemplate")[0].text, {data: window.application.results});
    $("#resultsColumn").html(template);

	// Load all the checkboxes from the filter section and 
	// synch them with the search term status from the server.
	// TODO(rafael.chiti) This logic should be on the server, changing the 
	// status of the chekboxes after loading the page is not "nice".
	checkBoxes = $(".sweetCheckbox");
	checkBoxes.each(function(index){
		if (window.application.searchTerm[this.title] === true) {
			$(this).trigger('turnOn');		
		} 
	});

	$('.hasTooltipsy').tooltipsy({
	    offset: [-10, 0],
	    show: function (e, $el) {
	        $el.css({
	            'left': parseInt($el[0].style.left.replace(/[a-z]/g, '')) - 50 + 'px',
	            'opacity': '0.0',
	            'display': 'block'
	        }).animate({
	            'left': parseInt($el[0].style.left.replace(/[a-z]/g, '')) + 50 + 'px',
	            'opacity': '1.0'
	        }, 300);
	    },
	    hide: function (e, $el) {
	        $el.slideUp(100);
	    },
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

});

// Each time the user clicks any of the options from the filter
// this functions is triggered.
function updateBoolFilter(checkBox, filterOption) {
	window.application.searchTerm[filterOption] = !$(checkBox).triggerHandler('isOn');
}





////////////////////////////////////////////////
//
// 		REMOVE THIS FUNCTIONS WHEN FINISHED
//


// TODO(rafael.chiti): Remove this. Just for debugging.
function alertSearchTerm() {

	alert(JSON.stringify(window.application.searchTerm));
	
}