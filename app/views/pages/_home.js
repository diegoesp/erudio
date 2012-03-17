window.application = {};
window.application.searchTerm = {};

// 
//	ON DOM READY
//
//	Init logic after page 'loading'
//
$(document).ready(function() {
    var template = _.template($("#activityTemplate")[0].text, {data: window.application.activities});
    $("#activitiesContainer").html(template);

});


//	When the user selects an activity from the first step on the wizard
//	the searchTerm object is updated and the wizard moves to the second step.
function selectActivity(htmlContainer) {
    id = $(htmlContainer).find("input[type=hidden]").get(0).value;
    window.application.searchTerm.activityId = id;
    right();
}


//
//	Unfold the section that contains more activities, in order
//	to display the full list of activities to the user.
//
function unfoldActivities() {
	$("#wizardSection").effect("size", {"to": {"height": "500px"}}, 800);
}

function foldActivities(functionToExecute) {
	$("#wizardSection").effect("size", {"to": {"height": "300px"}}, 800);
}




/////////////////////////////////////////
//
// 		SearchWizardSlider.js
//
/////////////////////////////////////

window.application.slider = {};

$(document).ready(function() {
	var slider = window.application.slider;
	slider.current = 0;

	setWidths();

	// Bind the window resize "recalc"
	$(window).resize(function(){
		setWidths();

		valueToMove = parseInt(- slider.sectionWidth * slider.current)
		$('#wizardSlider').stop().animate({
			left: valueToMove + 'px',
		}, 650, function() {
		});
	});

});


//
//	Recalculate the widths for the "sliding" boxes
//
//
function setWidths() {
	var slider = window.application.slider;

	slider.totalBoxes = $('#wizardSlider .slideBox').length;
	slider.sectionWidth = $('#wizardSliderWrapper').width();
	slider.boxesTotalWidth = slider.sectionWidth * slider.totalBoxes;

	$('#wizardSlider').width(slider.boxesTotalWidth);

	$("#wizardSlider .slideBox").each(function(){
		$(this).width(slider.sectionWidth);
	});
}

//
//	Move the slider to the right, one step.
//
//
function right() {

	// TODO(rafael.chiti): This should change for something generic.
	// When moving through the slides, firs, fold the panel. 
	foldActivities();

	var slider = window.application.slider;

	slider.current++;

	if (slider.current >= slider.totalBoxes) {
		slider.current = 0;
	}

	valueToMove = parseInt( - slider.sectionWidth * slider.current)

	$('#wizardSlider').stop().animate({
		left: valueToMove + 'px',
	}, 650, function() {
	});

}

//
//	Move the slider to the left, one step.
//
//
function left() {
	// TODO(rafael.chiti): This should change for something generic.
	// When moving through the slides, firs, fold the panel. 
	foldActivities();


	var slider = window.application.slider;

	slider.current--;
	if (slider.current < 0) {
		slider.current = slider.totalBoxes - 1;
	}

	valueToMove = parseInt(- slider.sectionWidth * slider.current)

	$('#wizardSlider').stop().animate({
		left: valueToMove + 'px',
	}, 650, function() {
	});

}


//////////////////////////////////////////////////
//
// 		The stuff below must be removed
//		when release a candidate version.
//
//////

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



