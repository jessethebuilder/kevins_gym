$(document).ready(ready);
$(document).on('page:load', ready);

function ready(){
  $('.datetimepicker').datetimepicker();

  //----------------footer scripts----------------------------
  //hover over for social icon links
  imageChangeOnLinkHover('.social_icon');
  //set page height so footer is always on bottom
  $('#page_content').css('min-height', $(window).height() - 400);

//  var s = skrollr.init();

  onMediaQuery('sm', function(){
    $('#top_nav a').css('border-bottom-width', '0px');
  }, function(){
  })


}