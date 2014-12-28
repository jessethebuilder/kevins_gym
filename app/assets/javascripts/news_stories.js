function setupNewsList(){
  $(document).ready(function(){
        colorStoriesOnHover();
      }
  )

  //places the right column above the left column
  onMediaQuery('md', function(){
    $('.col_right').insertBefore('.col_left');
  }, function(){
    $('.col_left').insertBefore ('.col_right');
  })

}

function colorStoriesOnHover(){
  $('.news_list a').hover(function(){
    $(this).closest('li').css('border-left', '2px solid #363636');
  }, function(){
    $(this).closest('li').css('border-left-color', 'white');

  })
}