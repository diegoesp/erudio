// Initial context for the Result page.
app.search = {};

//
// Initialization (called on DOM ready)
//
app.search.initialize = function() {
  // Initialize the SweetCheckboxes by calling the config method from the library
  configureSweetCheckboxes();

  // Bind the JSON written in the ERB to the template and render it.
  var template = _.template($("#searchTemplate")[0].text, {data : app.search.teachers});
  $("section#teacherList").append(template);

  $(".sweetCheckbox").each(function(index) {
      $(this).trigger('turnOff');
  });

  $(".sweetCheckbox").click(function() {
    app.search.updateBoolFilter(this, this.title);
  });

  $(".filter-row-zone-column").click(function() {
  })
  // Configure the ToolTipsy tool.
  app.search.initializeTooltipsy();
}

// Executed everytime a user clicks on the boolean filters
app.search.updateBoolFilter = function(checkBox, filterOption) {
  app.search.executeAjaxSearch();
}

app.search.executeAjaxSearch = function() {

  var activity_id = $.url().param("activity_id");
  var zone_id_csv = $.url().param("zone_id_csv");
  var goes_here = $.url().param("goes_here");
  var receives_people_here = $.url().param("receives_people_here");

  var rest_api_url = "/teachers/search?format=json";

  rest_api_url += "&activity_id=" + activity_id;
  rest_api_url += "&zone_id_csv=" + zone_id_csv;

  if (goes_here != undefined) rest_api_url += "&goes_here=" + goes_here;
  if (receives_people_here != undefined) rest_api_url += "&receives_people_here=" + receives_people_here;

  // Take all filters info for the query
  $(".sweetCheckbox").each(function(index) {
    var isOn = $(this).triggerHandler('isOn')
    if (isOn) rest_api_url += "&" + this.title + "=true";
  });

  $.ajax({url : rest_api_url,
    success : function(response) {
      $("section#teacherList").children().remove();
      var template = _.template($("#searchTemplate")[0].text, {data : response});
      $("section#teacherList").append(template);
    },
    error : function(xhr, ajaxOptions, thrownError) {
      alert(xhr.status);
      alert(thrownError);
    }
  });
}

// Initialize and configure the tooltips for this page (tooltipsy library)
app.search.initializeTooltipsy = function() {
  $('.hasTooltipsy').tooltipsy({
    offset : [ -10, 0 ],
    css : {
      'padding' : '10px',
      'max-width' : '200px',
      'color' : '#303030',
      'background-color' : '#f5f5b5',
      'border' : '1px solid #deca7e',
      '-moz-box-shadow' : '0 0 10px rgba(0, 0, 0, .5)',
      '-webkit-box-shadow' : '0 0 10px rgba(0, 0, 0, .5)',
      'box-shadow' : '0 0 10px rgba(0, 0, 0, .5)',
      'text-shadow' : 'none'
    }
  });
}