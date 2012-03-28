window.application = {};
window.application.searchTerm = {};
window.application.searchTerm.activitiesIds = [];
window.application.selectedActivities = [];

// 
//	ON DOM READY
//
//	Init logic after page 'loading'
//
$(document).ready(function () {
    var template = _.template($("#activityTemplate")[0].text, {data:window.application.featuredActivities, featured:true});
    $("#featuredActivitiesContainer").html(template);

    var template = _.template($("#activityTemplate")[0].text, {data:window.application.allActivities, featured:false});
    $("#allActivitiesContainer").html(template);

});


//	When the user selects an activity from the first step on the wizard
//	the searchTerm object is updated and the wizard moves to the second step.
function selectActivity(activityBox, isFeatured) {
    hiddenInput = $(activityBox).find("input[type=hidden]");
    activityId = hiddenInput.attr("value");


    $("#activitiesSection").find(".activityBox_" + activityId).each(function (index, activityBox) {

        if ($(activityBox).hasClass("activitySelected")) {
            // UNSELECT ACTIVITY
            $(activityBox).removeClass("activitySelected");

            indexOfActivityId = window.application.searchTerm.activitiesIds.indexOf(activityId);

            if (index === 0) {
                window.application.searchTerm.activitiesIds.splice(indexOfActivityId, 1);
            }

        } else {
            // SELECT ACTIVITY
            $(activityBox).addClass("activitySelected");

            if (index === 0) {
                window.application.searchTerm.activitiesIds.push(activityId);
            }
        }
    });

}


//
// Show all the activities
//
function seeMoreActivities(seeMoreDiv) {
    $('#featuredActivitiesContainerWrapper').hide("fade", {}, 500, function () {
        $('#allActivitiesContainerWrapper').show('fade', {}, 500);
    });


    $(seeMoreDiv).fadeOut('slow');
}


/////////////////////////////////////////
//
// 		SearchWizardSlider.js
//
/////////////////////////////////////

window.application.slider = {};

$(document).ready(function () {
    var slider = window.application.slider;
    slider.current = 0;

    setWidths();

    // Bind the window resize "recalc"
    $(window).resize(function () {
        setWidths();

        valueToMove = parseInt(-slider.sectionWidth * slider.current)
        $('#wizardSlider').stop().animate({
            left:valueToMove + 'px',
        }, 650, function () {
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

    $("#wizardSlider .slideBox").each(function () {
        $(this).width(slider.sectionWidth);
    });
}

//
//	Move the slider to the right, one step.
//
//
function right() {

    var slider = window.application.slider;

    slider.current++;

    if (slider.current >= slider.totalBoxes) {
        slider.current = 0;
    }

    valueToMove = parseInt(-slider.sectionWidth * slider.current)

    $('#wizardSlider').stop().animate({
        left:valueToMove + 'px',
    }, 650, function () {
    });

}

//
//	Move the slider to the left, one step.
//
//
function left() {

    var slider = window.application.slider;

    slider.current--;
    if (slider.current < 0) {
        slider.current = slider.totalBoxes - 1;
    }

    valueToMove = parseInt(-slider.sectionWidth * slider.current)

    $('#wizardSlider').stop().animate({
        left:valueToMove + 'px',
    }, 650, function () {
    });

}


//////////////////////////////////////////////////
//
// 		The stuff below must be removed 
//		when releasing a candidate version.
//
//////

// TODO(rafael.chiti): Remove this. Just for debugging.
function alertSearchTerm() {
    alert(JSON.stringify(window.application.searchTerm));
}
// TODO(rafael.chiti): Remove this. Just for debugging.
function postSearch() {
    jqxhr = $.ajax({
        type:'POST',
        url:'http://localhost:3000/pages/testPage/home',
        data:window.application.searchTerm,
        success:'postSearchSuccessCB',
        dataType:'json'
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



