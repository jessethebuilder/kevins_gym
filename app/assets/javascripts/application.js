// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require bootstrap
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require farm_tools
//= require skrollr
//= require_tree .

$(document).ready(function(){
  $('.datetimepicker').datetimepicker();

  //----------------footer scripts----------------------------
  //hover over for social icon links
  imageChangeOnLinkHover('.social_icon');
  //set page height so footer is always on bottom
  $('#page_content').css('min-height', $(window).height() - 400);

  var s = skrollr.init();

  onMediaQuery('sm', function(){
    $('#top_nav a').css('border-bottom-width', '0px');
  }, function(){
  })
})





