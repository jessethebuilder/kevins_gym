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


// --------------     Features Bar--------------------
function setupFeaturesBar(){
  $(document).ready(function(){

    onMediaQuery('md', function(){
      $('#features_bar').addClass('features_bar_mini');
    }, function(){
      $('#features_bar').removeClass('features_bar_mini');

      //remove padding from #features_bar
      $('#features_bar').find('li').css('padding-right', '0px');
      $('#features_bar').find('li').css('padding-left', '0px');
    })
  })
}

//function centerIconsOnFeaturesBarMini(){
//  var items = $('.features_bar_mini').find('li');
//  if(items.length > 0){
//    //assumes all items are the same width
//    var used_width = $(items[0]).width() * items.length;
//    var free_width = $('#features_bar').width() - used_width;
//
//    //padding is free_width divided by the number of items, divided by 2 (for padding-left/padding-right)
//    var padding_width = (free_width / items.length / 2) - 1;
//
//    items.each(function(i, item){
//      $(item).css('padding-right', padding_width + 'px');
//      $(item).css('padding-left', padding_width + 'px');
//    })
//  } else{
//    //remove padding when .features_bar_mini is removed
////    $(item).css('padding-right', '0px');
////    $(item).css('padding-left', '0px');
//  }
//}


