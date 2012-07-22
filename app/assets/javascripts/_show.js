// Initial context
app.show = {};

//
// Initialization (called on DOM ready)
//
app.show.initialize = function() {

  $("#new_search").click(function() {
    document.location.href = "/";
  });

  $("#back_to_results").click(function() {
    window.history.go(-1);
  });
}