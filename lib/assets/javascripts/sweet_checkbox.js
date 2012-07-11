function configureSweetCheckboxes() {

	$(".sweetCheckbox").each(function(){
		
		sweetCheckbox = $(this);
		
		// TODO(rafael.chiti): Is this necessary?, this should be manage differently.
		// By default set the "off" background to the checkbox
		sweetCheckbox.addClass("sweetCheckboxBGOff");
		
		// Create the piece of html that will be attached to each 'div checkbox'
		innerHtml = "<div class=\"sweetCheckboxBallContainer\"> <span class=\"sweetCheckboxBall sweetCheckboxBallOff\"></span> <input type=\"hidden\" value=\"false\"/> </div>";
		
		sweetCheckbox.append(innerHtml);
		
		// Iterate the DOM only once and get the "input" and "span" element.
		input = $($(this).find("input").get(0));
		span = $($(this).find("span").get(0));
		
		
		// Event that will be triggered each time the user 
		// clicks on the checkbox
		var clicked = function(event) {
			if (event.data.input.attr("value") === 'true') {
				event.data.sweetCheckbox.triggerHandler("turnOff");
			} else {
				event.data.sweetCheckbox.triggerHandler("turnOn");			
			}
		}
		
		// Change the checkbox to "on" state
		var turnOn = function(event) {
			event.data.span.switchClass( "sweetCheckboxBallOff", "sweetCheckboxBallOn", 500 );
			event.data.sweetCheckbox.switchClass( "sweetCheckboxBGOff", "sweetCheckboxBGOn", 200 );
			event.data.input.attr('value', 'true');

		}

		// Change the checkbox to "off" state		
		var turnOff = function(event) {
			event.data.span.switchClass( "sweetCheckboxBallOn", "sweetCheckboxBallOff", 500 );
			event.data.sweetCheckbox.switchClass( "sweetCheckboxBGOn", "sweetCheckboxBGOff", 200 );		
			event.data.input.attr('value', 'false');
		}
		
		var isOn = function(event) {
			return event.data.input.attr('value') === 'true';
		}
		
		// Here the event data object is used when calling 'jQuery.bind' (more information http://api.jquery.com/bind/)
		// The functions binded are using the 'event' object provided by jQuery in order to get the 
		// object literal that is being passed here (second argument of bind function). 
		sweetCheckbox.bind('turnOn', {sweetCheckbox: sweetCheckbox, span: span, input: input}, turnOn);
		sweetCheckbox.bind('turnOff',{sweetCheckbox: sweetCheckbox, span: span, input: input}, turnOff);
		sweetCheckbox.bind('isOn', {input: input}, isOn);
		sweetCheckbox.bind('click', {sweetCheckbox: sweetCheckbox, span: span, input: input}, clicked);
	});	
	
}

