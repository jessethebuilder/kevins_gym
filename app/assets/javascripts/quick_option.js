function quickOptionsBehaviors(){
  colorQuickOptionsRightBorderOnHover();
}

function colorQuickOptionsRightBorderOnHover(){
  $('.quick_options li a').hover(function(){
//    alert('xx');
    $(this).closest('li').css('border-right-color', '#363636');
  }, function(){
    $(this).closest('li').css('border-right-color', '#dddddd');

  })
}