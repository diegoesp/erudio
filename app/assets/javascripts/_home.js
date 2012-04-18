// Context for the home page.
app.home = {};

// Initialize the Search Term object. This object is going to be used
// to execute the final search query.
app.home.searchTerm = {};
app.home.searchTerm.activityId = undefined;
app.home.searchTerm.zonesIds = [];

app.home.activitySelected = false;
app.home.activityModeSelected = false;
app.home.zoneSelected = false;

// Object to store all the related information to the activities section
app.home.activitiesContext = {};
app.home.activitiesContext.moreActivitiesDisplayed = false;

// Object to store all the related information to the zones section
app.home.zonesContext = {};
app.home.zonesContext.moreZonesDisplayed = false;

//
// This method will be called on DOM ready.
//
app.home.initialize = function() {

	// Render the activities (featured activities and all activities).
	var template = _.template($("#activityTemplate")[0].text, {
		data : app.home.featuredActivities,
		featured : true
	});
	$("#featuredActivitiesContainer").html(template);

	var template = _.template($("#activityTemplate")[0].text, {
		data : app.home.allActivities,
		featured : false
	});
	$("#allActivitiesContainer").html(template);


	// Render the zones (featured zones and all zones).
	var template = _.template($("#zoneTemplate")[0].text, {
		data : app.home.featuredZones,
		featured : true
	});
	$("#featuredZonesContainer").html(template);
	
	var template = _.template($("#zoneTemplate")[0].text, {
		data : app.home.allZones,
		featured : false
	});
	$("#allZonesContainer").html(template);


	// Initialize the Wizard component
	app.home.wizard.initialize();
	
	// Bind some events required by this page.
	app.eventHolder.on('activityClicked', app.home.EVENT_activityClicked);
	app.eventHolder.on('activityModeClicked', app.home.EVENT_activityModeClicked);
	app.eventHolder.on('zoneClicked', app.home.EVENT_zoneClicked);


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

//
// Show all the zones / hide all the zones
//
app.home.seeMoreZones = function(seeMoreDiv) {
	
	if (app.home.zonesContext.moreZonesDisplayed === false) {
		
		$('#featuredZonesContainerWrapper').hide("fade", {}, 500, function() {
			$('#allZonesContainerWrapper').show('fade', {}, 500);
		});
		app.home.zonesContext.moreZonesDisplayed = true;
		$('#seeMoreZones').switchClass('seeMore','seeLess','normal');

	} else {
		
		$('#allZonesContainerWrapper').hide("fade", {}, 500, function() {
			$('#featuredZonesContainerWrapper').show('fade', {}, 500);
		});
		app.home.zonesContext.moreZonesDisplayed = false;	
		$('#seeMoreZones').switchClass('seeLess','seeMore','normal');
		
	}

}

//
//
// WIZARD STEP #1 - Action
//
//
// A few dirty things are being done here in order to select an activity
// from both lists.
// When the user selects an activity from the first step on the wizard
// the searchTerm object is updated.
//
app.home.selectActivity = function(activityBox) {
	activityId = activityBox.find("input[type=hidden]").attr("value");

	// If the user clicked the activity that was already selected then just 
	// end this call.
	if (activityBox.hasClass("js-selected")) {
		return;
	}


	// Search for all the activities and "unselect" the one that was selected
	// and then select the one that the user clicked.
	$("section#activities .js-selected").each(function(index, each) {
		$(each).removeClass("activitySelected js-selected");
		app.home.activityId = undefined;
	});

	// Select the one clicked by the user
	$("section#activities .js-activityBox_" + activityId).each(function(index, each) {
		$(each).addClass("activitySelected js-selected");	
	});
	app.home.searchTerm.activityId = activityId;

					
	if(app.home.searchTerm.activityId) {
		app.home.activitySelected = true;
	} else {
		app.home.activitySelected = false;	
	}
	
	app.eventHolder.triggerHandler('activityClicked');
}

//
//
// WIZARD STEP #2 - Action
//
//
// Select the kind of class. Store the string representation
// on the search term.
//
app.home.selectActivityMode = function(button, type) {

	if (button.hasClass("js-selected")) {
		return;
	}
	
	$("section.js-wizard .js-activityMode").each(function(index, each){
		$(each).removeClass("js-selected activityModeButtonSelected");
	});
	
	button.addClass("js-selected activityModeButtonSelected");

	app.home.searchTerm.activityMode = type;
	
	// Its an option component so as soon as the user clicks on one
	// of the optiones the 'selected' state will be true until the user
	// leaves the page.
	app.home.activityModeSelected = true;
	
	app.eventHolder.triggerHandler('activityModeClicked');

}


//
//
// WIZARD STEP #3 - Action
//
//
// A few dirty things are being done here in order to select multiple zones
// from both lists.
// When the user selects an activity from the first step on the wizard
// the searchTerm object is updated.
//
app.home.selectZone = function(zoneBox) {
	zoneId = zoneBox.find("input[type=hidden]").attr("value");

	$("section#zones").find(".js-zoneBox_" + zoneId).each(
		function(index, eachZoneBox) {

			eachZoneBox = $(eachZoneBox);

			if (eachZoneBox.hasClass("js-selected")) {
				// UNSELECT ZONE
				eachZoneBox.removeClass("zoneSelected js-selected");
			
				indexOfZoneId = app.home.searchTerm.zonesIds.indexOf(zoneId);
			
				if (index === 0) {
					app.home.searchTerm.zonesIds.splice(indexOfZoneId, 1);
				}
			
			} else {
				// SELECT ACTIVITY
				eachZoneBox.addClass("zoneSelected js-selected");
			
				if (index === 0) {
					app.home.searchTerm.zonesIds.push(zoneId);
				}
			}
	});

}



//
// HOME EVENTS
//
app.home.EVENT_activityClicked = function () {
	if (app.home.activitySelected === true) {
		app.home.wizard.enableNextButton();	
	} else {
		app.home.wizard.disableNextButton();	
	}
}
app.home.EVENT_activityModeClicked = function() {
	if (app.home.activityModeSelected === true) {
		app.home.wizard.enableNextButton();	
	} else {
		app.home.wizard.disableNextButton();	
	}
}
app.home.EVENT_zoneClicked = function() {
	if (app.home.zoneSelected === true) {
		app.home.wizard.enableNextButton();	
	} else {
		app.home.wizard.disableNextButton();	
	}
}

//
// Wizard Events
// 
app.home.EVENT_wizardInitialized = function() {
	app.home.wizard.enableBackButton();
	app.home.wizard.hideBackButton();
	app.home.wizard.disableNextButton();
}

app.home.EVENT_wizardMoved = function() {
	currentStep = app.home.wizard.slider.current;

	if (currentStep === 0) {
		app.home.wizard.hideBackButton();
		
		app.home.activitySelected === true ? app.home.wizard.enableNextButton() :
			app.home.wizard.disableNextButton();
	}	
	
	if (currentStep === 1) {
		app.home.wizard.showBackButton();	
		
		app.home.activityModeSelected === true ? app.home.wizard.enableNextButton() :
			app.home.wizard.disableNextButton();		
	}
	
	if (currentStep === 2) {
		app.home.wizard.disableNextButton();
	}	
	
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

