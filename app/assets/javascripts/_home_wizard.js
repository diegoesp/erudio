// Wizard object
app.home.wizard = $({});
app.home.wizard.slider = {};
app.home.wizard.backButton = {};
app.home.wizard.nextButton = {};

//
// Wizard Initialization
// 
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
	
	app.home.wizard.backButton = $("section.js-wizard .js-wizardBackButton");
	app.home.wizard.nextButton = $("section.js-wizard .js-wizardNextButton");
	
	app.home.wizard.on('wizardMoved', app.home.EVENT_wizardMoved);
	app.home.wizard.on('wizardInitialized', app.home.EVENT_wizardInitialized);
	
	app.home.wizard.triggerHandler('wizardInitialized');
}

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

	app.home.wizard.triggerHandler('wizardMoved');
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
	
	app.home.wizard.triggerHandler('wizardMoved');
}

//
// Enable and Disable the navigation buttons.
//
app.home.wizard.enableBackButton = function() {
	app.home.wizard.backButton.off('click');
	app.home.wizard.backButton.on('click', app.home.wizard.back);
	app.home.wizard.backButton.removeClass('wizardNavButtonDisabled');
}
app.home.wizard.disableBackButton = function() {
	app.home.wizard.backButton.off('click');
	app.home.wizard.backButton.addClass('wizardNavButtonDisabled');
}
app.home.wizard.enableNextButton = function() {
	app.home.wizard.nextButton.off('click');
	app.home.wizard.nextButton.on('click', app.home.wizard.next);
	app.home.wizard.nextButton.removeClass('wizardNavButtonDisabled');
}
app.home.wizard.disableNextButton = function() {
	app.home.wizard.nextButton.off('click');
	app.home.wizard.nextButton.addClass('wizardNavButtonDisabled');
}
app.home.wizard.hideNextButton = function() {
	app.home.wizard.nextButton.hide();
}
app.home.wizard.showNextButton = function() {
	app.home.wizard.nextButton.show();
}
app.home.wizard.hideBackButton = function() {
	app.home.wizard.backButton.hide();
}
app.home.wizard.showBackButton = function() {
	app.home.wizard.backButton.show();
}

