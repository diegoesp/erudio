// Create an initial context.
window.app = {};

// Initialize the Search Term object. This object is going to be used
// to execute the final search query.
window.app.searchTerm = {};
window.app.searchTerm.activitiesIds = [];

// Object to store all the related information to the activities section
window.app.activitiesContext = {};
window.app.activitiesContext.moreActivitiesDisplayed = false;



// 
// ON DOM READY
//
// Init logic after page 'loading'
//
$(document).ready(function() {
	
	// Render the activities (featured activities and all activities).
	var template = _.template($("#activityTemplate")[0].text, {
		data : window.app.featuredActivities,
		featured : true
	});
	$("#featuredActivitiesContainer").html(template);

	var template = _.template($("#activityTemplate")[0].text, {
		data : window.app.allActivities,
		featured : false
	});
	$("#allActivitiesContainer").html(template);

	// Initialize the Wizard component
	window.app.wizard.initialize();
	
	
	// Load the next button from the wizard
	window.app.activitiesContext.activitiesWizardNextButton = $("#activitiesWizardNextButton");
});

//
// A few dirty things are being done here in order to select an activity
// from both lists.
// When the user selects an activity from the first step on the wizard
// the searchTerm object is updated.
//
function selectActivity(activityBox, isFeatured) {
	activityId = $(activityBox).find("input[type=hidden]").attr("value");

	$("#activitiesSection")
			.find(".activityBox_" + activityId)
			.each(
					function(index, activityBox) {

						if ($(activityBox).hasClass("activitySelected")) {
							// UNSELECT ACTIVITY
							$(activityBox).removeClass("activitySelected");

							indexOfActivityId = window.app.searchTerm.activitiesIds
									.indexOf(activityId);

							if (index === 0) {
								window.app.searchTerm.activitiesIds
										.splice(indexOfActivityId, 1);
							}

						} else {
							// SELECT ACTIVITY
							$(activityBox).addClass("activitySelected");

							if (index === 0) {
								window.app.searchTerm.activitiesIds
										.push(activityId);
							}
						}
					});
					
	// TODO(rafael.chiti): This should not be here. I need to find a place to put all this logic together.
	// Having observers ont he objects would be a nice solution. I need to research if underscore has any
	// usefull utility or if we need to add any other framework.				
	if (window.app.searchTerm.activitiesIds.length > 0) {
		window.app.activitiesContext.activitiesWizardNextButton.removeClass("wizardNextButtonDisabled");
		window.app.activitiesContext.activitiesWizardNextButton.attr('onclick', 'window.app.wizard.next()');
	} else {
		window.app.activitiesContext.activitiesWizardNextButton.addClass("wizardNextButtonDisabled");
		window.app.activitiesContext.activitiesWizardNextButton.attr('onclick', '');
	}
}

//
// Show all the activities / hide all the activities
//
function seeMoreActivities(seeMoreDiv) {
	
	if (window.app.activitiesContext.moreActivitiesDisplayed === false) {
		
		$('#featuredActivitiesContainerWrapper').hide("fade", {}, 500, function() {
			$('#allActivitiesContainerWrapper').show('fade', {}, 500);
		});
		window.app.activitiesContext.moreActivitiesDisplayed = true;
		$('#seeMoreActivities').switchClass('seeMore','seeLess','normal');

	} else {
		
		$('#allActivitiesContainerWrapper').hide("fade", {}, 500, function() {
			$('#featuredActivitiesContainerWrapper').show('fade', {}, 500);
		});
		window.app.activitiesContext.moreActivitiesDisplayed = false;	
		$('#seeMoreActivities').switchClass('seeLess','seeMore','normal');
		
	}

}










// ///////////////////////////////////////
//
// SearchWizardSlider.js
//
// ///////////////////////////////////

// Wizard object
window.app.wizard = {};
window.app.wizard.slider = {};

//
// Recalculate the widths for the "sliding" boxes
//
//
window.app.wizard.setWidths = function() {
	var slider = window.app.wizard.slider;

	slider.totalBoxes = $('#wizardSlider .slideBox').length;
	slider.sectionWidth = $('#wizardSliderWrapper').width();
	slider.boxesTotalWidth = slider.sectionWidth * slider.totalBoxes;

	$('#wizardSlider').width(slider.boxesTotalWidth);

	$("#wizardSlider .slideBox").each(function() {
		$(this).width(slider.sectionWidth);
	});
}


window.app.wizard.initialize = function() {

	var slider = window.app.wizard.slider;
	slider.current = 0;

	window.app.wizard.setWidths();

	// Bind the window resize "recalc"
	$(window).resize(function() {
		window.app.wizard.setWidths();

		valueToMove = parseInt(-slider.sectionWidth * slider.current)
		$('#wizardSlider').stop().animate({
			left : valueToMove + 'px',
		}, 650, function() {
		});
	});

}



//
// Move the slider to the right, one step.
//
//
window.app.wizard.next = function() {

	var slider = window.app.wizard.slider;

	slider.current++;

	if (slider.current >= slider.totalBoxes) {
		slider.current = 0;
	}

	valueToMove = parseInt(-slider.sectionWidth * slider.current)

	$('#wizardSlider').stop().animate({
		left : valueToMove + 'px',
	}, 650, function() {
	});

}

//
// Move the slider to the left, one step.
//
//
window.app.wizard.back = function() {

	var slider = window.app.wizard.slider;

	slider.current--;
	if (slider.current < 0) {
		slider.current = slider.totalBoxes - 1;
	}

	valueToMove = parseInt(-slider.sectionWidth * slider.current)

	$('#wizardSlider').stop().animate({
		left : valueToMove + 'px',
	}, 650, function() {
	});

}

// ////////////////////////////////////////////////
//
// The stuff below must be removed
// when releasing a candidate version.
//
// ////

// TODO(rafael.chiti): Remove this. Just for debugging.
function alertSearchTerm() {
	alert(JSON.stringify(window.app.searchTerm));
}
// TODO(rafael.chiti): Remove this. Just for debugging.
function postSearch() {
	jqxhr = $.ajax({
		type : 'POST',
		url : 'http://localhost:3000/pages/testPage/home',
		data : window.app.searchTerm,
		success : 'postSearchSuccessCB',
		dataType : 'json'
	});
	// jqxhr.error = "postSearchFailCB";

}
// TODO(rafael.chiti): Remove this. Just for debuggin (the call back function
// for the ajax call).
function postSearchSuccessCB(data, textStatus, jqXHR) {
	alert("response succeed");
}

// TODO(rafael.chiti): Remove this. Just for debuggin (the call back function
// for the ajax call).
function postSearchFailCB() {
	alert("request failed");
}
