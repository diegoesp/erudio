// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//

//= require jquery
//= require jquery-ui
//= require modernizr
//= require sweet_checkbox
//= require tooltipsy
//= require underscore
//= require jquery.url
//= require underscore.string.min
//= require_self
//= require_tree .

// Create the initial context. All the functions, page related objects, etc
// are going to be stored inside this object.
window.app = {};

// This object will be used to store jQuery events (binded with '$.on()').
// More references using jQuery 'on' here: http://api.jquery.com/on/
window.app.eventHolder = $({});

_.templateSettings = {
    evaluate : /\{\[([\s\S]+?)\]\}/g,
    interpolate : /\{\{([\s\S]+?)\}\}/g
};