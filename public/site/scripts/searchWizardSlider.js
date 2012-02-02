
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
	

/*
*  Recalculate the widths for the "sliding" boxes
*
*/
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


function right() {
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

function left() {
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
