// Context for the home page.
app.home = {};

// Initialize the Search Term object. This object is going to be used
// to execute the final search query.
app.home.searchTerm = {};
app.home.searchTerm.activitiesIds = [];

// Object to store all the related information to the activities section
app.home.activitiesContext = {};
app.home.activitiesContext.moreActivitiesDisplayed = false;

//
// A few dirty things are being done here in order to select an activity
// from both lists.
// When the user selects an activity from the first step on the wizard
// the searchTerm object is updated.
//
app.home.selectActivity = function(activityBox, isFeatured) {
	activityId = $(activityBox).find("input[type=hidden]").attr("value");

	$("section#activities")
			.find(".activityBox_" + activityId)
			.each(
					function(index, activityBox) {

						if ($(activityBox).hasClass("activitySelected")) {
							// UNSELECT ACTIVITY
							$(activityBox).removeClass("activitySelected");

							indexOfActivityId = app.home.searchTerm.activitiesIds
									.indexOf(activityId);

							if (index === 0) {
								app.home.searchTerm.activitiesIds
										.splice(indexOfActivityId, 1);
							}

						} else {
							// SELECT ACTIVITY
							$(activityBox).addClass("activitySelected");

							if (index === 0) {
								app.home.searchTerm.activitiesIds
										.push(activityId);
							}
						}
					});
					
	// TODO(rafael.chiti): This should not be here. I need to find a place to put all this logic together.
	// Having observers ont he objects would be a nice solution. I need to research if underscore has any
	// usefull utility or if we need to add any other framework.				
	if (app.home.searchTerm.activitiesIds.length > 0) {
		app.home.activitiesContext.activitiesWizardNextButton.removeClass("wizardNextButtonDisabled");
		app.home.activitiesContext.activitiesWizardNextButton.attr('onclick', 'app.home.wizard.next()');
	} else {
		app.home.activitiesContext.activitiesWizardNextButton.addClass("wizardNextButtonDisabled");
		app.home.activitiesContext.activitiesWizardNextButton.attr('onclick', '');
	}
}

//
// Show all the activities / hide all the activities
//
app.home.seeMoreActivities = function(seeMoreDiv) {
	
	if (app.home.activitiesContext.moreActivitiesDisplayed === false) {
		
		$('#featuredActivitiesContainerWrapper').hide("fade", {}, 500, function() {
			$('#allActivitiesContainerWrapper').show('fade', {}, 500);
		});
		app.home.activitiesContext.moreActivitiesDisplayed = true;
		$('#seeMoreActivities').switchClass('seeMore','seeLess','normal');

	} else {
		
		$('#allActivitiesContainerWrapper').hide("fade", {}, 500, function() {
			$('#featuredActivitiesContainerWrapper').show('fade', {}, 500);
		});
		app.home.activitiesContext.moreActivitiesDisplayed = false;	
		$('#seeMoreActivities').switchClass('seeLess','seeMore','normal');
		
	}

}










// ///////////////////////////////////////
//
// SearchWizardSlider.js
//
// ///////////////////////////////////

// Wizard object
app.home.wizard = {};
app.home.wizard.slider = {};

//
// Recalculate the widths for the "sliding" boxes
//
//
app.home.wizard.setWidths = function() {
	var slider = app.home.wizard.slider;

	slider.totalBoxes = $('section#wizard #slider .slideBox').length;
	slider.sectionWidth = $('section#wizard #sliderWrapper').width();
	slider.boxesTotalWidth = slider.sectionWidth * slider.totalBoxes;

	$('section#wizard #slider').width(slider.boxesTotalWidth);

	$("section#wizard #slider .slideBox").each(function() {
		$(this).width(slider.sectionWidth);
	});
}


app.home.wizard.initialize = function() {

	var slider = app.home.wizard.slider;
	slider.current = 0;

	app.home.wizard.setWidths();

	// Bind the window resize "recalc"
	$(window).resize(function() {
		app.home.wizard.setWidths();

		valueToMove = parseInt(-slider.sectionWidth * slider.current)
		$('section#wizard #slider').stop().animate({
			left : valueToMove + 'px',
		}, 650, function() {
		});
	});

}



//
// Move the slider to the right, one step.
//
//
app.home.wizard.next = function() {

	var slider = app.home.wizard.slider;

	slider.current++;

	if (slider.current >= slider.totalBoxes) {
		slider.current = 0;
	}

	valueToMove = parseInt(-slider.sectionWidth * slider.current)

	$('section#wizard #slider').stop().animate({
		left : valueToMove + 'px',
	}, 650, function() {
	});

}

//
// Move the slider to the left, one step.
//
//
app.home.wizard.back = function() {

	var slider = app.home.wizard.slider;

	slider.current--;
	if (slider.current < 0) {
		slider.current = slider.totalBoxes - 1;
	}

	valueToMove = parseInt(-slider.sectionWidth * slider.current)

	$('section#wizard #slider').stop().animate({
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
app.home.alertSearchTerm = function() {
	alert(JSON.stringify(app.home.searchTerm));
}

