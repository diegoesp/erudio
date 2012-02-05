function configureSweetCheckboxes() {

	$(".sweetCheckbox").each(function(){
		
		// TODO(rafael.chiti): Is this necessary?, this should be manage differently.
		// By default set the "off" background to the checkbox
		$(this).addClass("sweetCheckboxBGOff");
		
		// Create the piece of html that will be attached to each 'div checkbox'
		innerHtml = "<div class=\"sweetCheckboxBallContainer\"> <span class=\"sweetCheckboxBall sweetCheckboxBallOff\"></span> <input type=\"hidden\" value=\"false\"/> </div>";
		
		$(this).append(innerHtml);
		
		// Event that will be triggered each time the user 
		// clicks on the checkbox
		var clicked = function() {
			if ($($(this).find("input").get(0)).attr("value") === 'true') {
				$(this).triggerHandler("turnOff");
			} else {
				$(this).triggerHandler("turnOn");			
			}
		}
		
		// Change the checkbox to "on" satate
		var turnOn = function() {
			$($(this).find("span").get(0)).switchClass( "sweetCheckboxBallOff", "sweetCheckboxBallOn", 500 );
			$(this).switchClass( "sweetCheckboxBGOff", "sweetCheckboxBGOn", 200 );
			$($(this).find("input").get(0)).attr('value', 'true');
		}

		// Change the checkbox to "off" satate		
		var turnOff = function() {
			$($(this).find("span").get(0)).switchClass( "sweetCheckboxBallOn", "sweetCheckboxBallOff", 500 );
			$(this).switchClass( "sweetCheckboxBGOn", "sweetCheckboxBGOff", 200 );		
			$($(this).find("input").get(0)).attr('value', 'false');
		}
		
		var isOn = function() {
			return $($(this).find("input").get(0)).attr('value') === 'true';
		}
		
		$(this).bind('turnOn', turnOn);
		$(this).bind('turnOff', turnOff);
		$(this).bind('isOn', isOn);
		$(this).bind('click', clicked);
	});	
	
}

